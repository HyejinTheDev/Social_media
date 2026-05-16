import { OnGatewayConnection, OnGatewayDisconnect } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { JwtService } from '@nestjs/jwt';
import { ChatService } from './chat.service';
import { CommunitiesService } from '../communities/communities.service';
export declare class ChatGateway implements OnGatewayConnection, OnGatewayDisconnect {
    private chatService;
    private jwtService;
    private communitiesService;
    server: Server;
    private onlineUsers;
    constructor(chatService: ChatService, jwtService: JwtService, communitiesService: CommunitiesService);
    handleConnection(client: Socket): Promise<void>;
    handleDisconnect(client: Socket): void;
    handleSendMessage(client: Socket, data: {
        conversationId: string;
        content: string;
        imageUrl?: string;
    }): Promise<({
        sender: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
    } & {
        id: string;
        createdAt: Date;
        content: string;
        imageUrl: string | null;
        isRead: boolean;
        senderId: string;
        conversationId: string;
    }) | undefined>;
    handleJoinConversation(client: Socket, data: {
        conversationId: string;
    }): void;
    handleLeaveConversation(client: Socket, data: {
        conversationId: string;
    }): void;
    handleTyping(client: Socket, data: {
        conversationId: string;
        typing: boolean;
    }): void;
    handleMarkRead(client: Socket, data: {
        conversationId: string;
    }): Promise<void>;
    handleJoinChannel(client: Socket, data: {
        channelId: string;
    }): void;
    handleLeaveChannel(client: Socket, data: {
        channelId: string;
    }): void;
    handleSendChannelMessage(client: Socket, data: {
        channelId: string;
        content: string;
        imageUrl?: string;
    }): Promise<({
        sender: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        content: string;
        channelId: string;
        imageUrl: string | null;
        senderId: string;
    }) | undefined>;
    private voiceRooms;
    handleVoiceJoin(client: Socket, data: {
        channelId: string;
        username: string;
        avatar?: string;
    }): Promise<void>;
    handleVoiceLeave(client: Socket, data: {
        channelId: string;
    }): void;
    handleVoiceToggleMic(client: Socket, data: {
        channelId: string;
        isMuted: boolean;
    }): void;
    private cleanupVoiceRooms;
    sendToUser(userId: string, event: string, data: any): void;
    isUserOnline(userId: string): boolean;
    getOnlineUserIds(): string[];
}
