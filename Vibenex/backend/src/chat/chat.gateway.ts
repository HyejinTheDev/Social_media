import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  OnGatewayConnection,
  OnGatewayDisconnect,
  ConnectedSocket,
  MessageBody,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { JwtService } from '@nestjs/jwt';
import { ChatService } from './chat.service';

import { CommunitiesService } from '../communities/communities.service';

@WebSocketGateway({
  cors: { origin: '*' },
  namespace: '/chat',
})
export class ChatGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  // userId → socketId mapping
  private onlineUsers = new Map<string, string>();

  constructor(
    private chatService: ChatService,
    private jwtService: JwtService,
    private communitiesService: CommunitiesService,
  ) {}

  async handleConnection(client: Socket) {
    try {
      const token = client.handshake.auth?.token || client.handshake.headers?.authorization?.replace('Bearer ', '');
      if (!token) {
        client.disconnect();
        return;
      }

      const payload = this.jwtService.verify(token);
      const userId = payload.sub;
      client.data.userId = userId;

      // Track online status
      this.onlineUsers.set(userId, client.id);

      // Join user's own room for targeted messages
      client.join(`user:${userId}`);

      // Broadcast online status
      this.server.emit('user:online', { userId, online: true });
      console.log(`🟢 User ${userId} connected (${client.id})`);
    } catch (e) {
      console.log('❌ WS auth failed:', e.message);
      client.disconnect();
    }
  }

  handleDisconnect(client: Socket) {
    const userId = client.data.userId;
    if (userId) {
      this.onlineUsers.delete(userId);
      this.cleanupVoiceRooms(userId);
      this.server.emit('user:online', { userId, online: false });
      console.log(`🔴 User ${userId} disconnected`);
    }
  }

  @SubscribeMessage('message:send')
  async handleSendMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { conversationId: string; content: string; imageUrl?: string },
  ) {
    const senderId = client.data.userId;
    if (!senderId) return;

    try {
      const message = await this.chatService.sendMessage(
        data.conversationId,
        senderId,
        data.content,
        data.imageUrl,
      );

      // Emit to conversation room
      this.server.to(`conversation:${data.conversationId}`).emit('message:new', message);

      // Also emit to both users' rooms (in case they haven't joined conv room)
      const conversation = await this.chatService.getOrCreateConversation(senderId, senderId);
      // For the receiver, find other participant
      // We send to the conversation room; clients join it when they open the chat
      return message;
    } catch (e) {
      client.emit('error', { message: e.message });
    }
  }

  @SubscribeMessage('conversation:join')
  handleJoinConversation(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { conversationId: string },
  ) {
    client.join(`conversation:${data.conversationId}`);
    console.log(`User ${client.data.userId} joined conversation:${data.conversationId}`);
  }

  @SubscribeMessage('conversation:leave')
  handleLeaveConversation(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { conversationId: string },
  ) {
    client.leave(`conversation:${data.conversationId}`);
  }

  @SubscribeMessage('message:typing')
  handleTyping(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { conversationId: string; typing: boolean },
  ) {
    client.to(`conversation:${data.conversationId}`).emit('message:typing', {
      userId: client.data.userId,
      typing: data.typing,
    });
  }

  @SubscribeMessage('message:read')
  async handleMarkRead(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { conversationId: string },
  ) {
    const userId = client.data.userId;
    if (!userId) return;

    await this.chatService.markAsRead(data.conversationId, userId);
    client.to(`conversation:${data.conversationId}`).emit('message:read', {
      conversationId: data.conversationId,
      readBy: userId,
    });
  }

  @SubscribeMessage('channel:join')
  handleJoinChannel(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { channelId: string },
  ) {
    client.join(`channel:${data.channelId}`);
    console.log(`User ${client.data.userId} joined channel:${data.channelId}`);
  }

  @SubscribeMessage('channel:leave')
  handleLeaveChannel(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { channelId: string },
  ) {
    client.leave(`channel:${data.channelId}`);
  }

  @SubscribeMessage('channel:message:send')
  async handleSendChannelMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { channelId: string; content: string; imageUrl?: string },
  ) {
    const senderId = client.data.userId;
    if (!senderId) return;

    try {
      const message = await this.communitiesService.sendChannelMessage(
        data.channelId,
        senderId,
        data.content,
        data.imageUrl,
      );

      this.server.to(`channel:${data.channelId}`).emit('channel:message:new', message);
      return message;
    } catch (e) {
      client.emit('error', { message: e.message });
    }
  }

  // ─── Voice Room Events ───

  // channelId → Set of { userId, username, avatar, isMuted }
  private voiceRooms = new Map<string, Map<string, { userId: string; username: string; avatar?: string; isMuted: boolean }>>();

  @SubscribeMessage('voice:join')
  async handleVoiceJoin(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { channelId: string; username: string; avatar?: string },
  ) {
    const userId = client.data.userId;
    if (!userId) return;

    const channelId = data.channelId;
    client.join(`voice:${channelId}`);

    if (!this.voiceRooms.has(channelId)) {
      this.voiceRooms.set(channelId, new Map());
    }

    const participant = {
      userId,
      username: data.username || 'User',
      avatar: data.avatar,
      isMuted: true,
    };

    this.voiceRooms.get(channelId)!.set(userId, participant);

    // Send current participant list to the joining user
    const participants = Array.from(this.voiceRooms.get(channelId)!.values());
    client.emit('voice:participants', { channelId, participants });

    // Notify others that someone joined
    client.to(`voice:${channelId}`).emit('voice:user:joined', { channelId, participant });

    console.log(`🎙️ User ${userId} joined voice room ${channelId} (${participants.length} participants)`);
  }

  @SubscribeMessage('voice:leave')
  handleVoiceLeave(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { channelId: string },
  ) {
    const userId = client.data.userId;
    if (!userId) return;

    const channelId = data.channelId;
    client.leave(`voice:${channelId}`);

    if (this.voiceRooms.has(channelId)) {
      this.voiceRooms.get(channelId)!.delete(userId);
      if (this.voiceRooms.get(channelId)!.size === 0) {
        this.voiceRooms.delete(channelId);
      }
    }

    this.server.to(`voice:${channelId}`).emit('voice:user:left', { channelId, userId });
    console.log(`🔇 User ${userId} left voice room ${channelId}`);
  }

  @SubscribeMessage('voice:toggle-mic')
  handleVoiceToggleMic(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { channelId: string; isMuted: boolean },
  ) {
    const userId = client.data.userId;
    if (!userId) return;

    const channelId = data.channelId;
    if (this.voiceRooms.has(channelId) && this.voiceRooms.get(channelId)!.has(userId)) {
      this.voiceRooms.get(channelId)!.get(userId)!.isMuted = data.isMuted;
    }

    this.server.to(`voice:${channelId}`).emit('voice:mic:toggled', {
      channelId,
      userId,
      isMuted: data.isMuted,
    });
  }

  // Clean up voice rooms on disconnect
  private cleanupVoiceRooms(userId: string) {
    for (const [channelId, participants] of this.voiceRooms.entries()) {
      if (participants.has(userId)) {
        participants.delete(userId);
        this.server.to(`voice:${channelId}`).emit('voice:user:left', { channelId, userId });
        if (participants.size === 0) {
          this.voiceRooms.delete(channelId);
        }
      }
    }
  }

  // Helper: send message to a specific user
  sendToUser(userId: string, event: string, data: any) {
    this.server.to(`user:${userId}`).emit(event, data);
  }

  isUserOnline(userId: string): boolean {
    return this.onlineUsers.has(userId);
  }

  getOnlineUserIds(): string[] {
    return Array.from(this.onlineUsers.keys());
  }
}
