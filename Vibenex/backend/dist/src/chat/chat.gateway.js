"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatGateway = void 0;
const websockets_1 = require("@nestjs/websockets");
const socket_io_1 = require("socket.io");
const jwt_1 = require("@nestjs/jwt");
const chat_service_1 = require("./chat.service");
const communities_service_1 = require("../communities/communities.service");
let ChatGateway = class ChatGateway {
    chatService;
    jwtService;
    communitiesService;
    server;
    onlineUsers = new Map();
    constructor(chatService, jwtService, communitiesService) {
        this.chatService = chatService;
        this.jwtService = jwtService;
        this.communitiesService = communitiesService;
    }
    async handleConnection(client) {
        try {
            const token = client.handshake.auth?.token || client.handshake.headers?.authorization?.replace('Bearer ', '');
            if (!token) {
                client.disconnect();
                return;
            }
            const payload = this.jwtService.verify(token);
            const userId = payload.sub;
            client.data.userId = userId;
            this.onlineUsers.set(userId, client.id);
            client.join(`user:${userId}`);
            this.server.emit('user:online', { userId, online: true });
            console.log(`🟢 User ${userId} connected (${client.id})`);
        }
        catch (e) {
            console.log('❌ WS auth failed:', e.message);
            client.disconnect();
        }
    }
    handleDisconnect(client) {
        const userId = client.data.userId;
        if (userId) {
            this.onlineUsers.delete(userId);
            this.cleanupVoiceRooms(userId);
            this.server.emit('user:online', { userId, online: false });
            console.log(`🔴 User ${userId} disconnected`);
        }
    }
    async handleSendMessage(client, data) {
        const senderId = client.data.userId;
        if (!senderId)
            return;
        try {
            const message = await this.chatService.sendMessage(data.conversationId, senderId, data.content, data.imageUrl);
            this.server.to(`conversation:${data.conversationId}`).emit('message:new', message);
            const conversation = await this.chatService.getOrCreateConversation(senderId, senderId);
            return message;
        }
        catch (e) {
            client.emit('error', { message: e.message });
        }
    }
    handleJoinConversation(client, data) {
        client.join(`conversation:${data.conversationId}`);
        console.log(`User ${client.data.userId} joined conversation:${data.conversationId}`);
    }
    handleLeaveConversation(client, data) {
        client.leave(`conversation:${data.conversationId}`);
    }
    handleTyping(client, data) {
        client.to(`conversation:${data.conversationId}`).emit('message:typing', {
            userId: client.data.userId,
            typing: data.typing,
        });
    }
    async handleMarkRead(client, data) {
        const userId = client.data.userId;
        if (!userId)
            return;
        await this.chatService.markAsRead(data.conversationId, userId);
        client.to(`conversation:${data.conversationId}`).emit('message:read', {
            conversationId: data.conversationId,
            readBy: userId,
        });
    }
    handleJoinChannel(client, data) {
        client.join(`channel:${data.channelId}`);
        console.log(`User ${client.data.userId} joined channel:${data.channelId}`);
    }
    handleLeaveChannel(client, data) {
        client.leave(`channel:${data.channelId}`);
    }
    async handleSendChannelMessage(client, data) {
        const senderId = client.data.userId;
        if (!senderId)
            return;
        try {
            const message = await this.communitiesService.sendChannelMessage(data.channelId, senderId, data.content, data.imageUrl);
            this.server.to(`channel:${data.channelId}`).emit('channel:message:new', message);
            return message;
        }
        catch (e) {
            client.emit('error', { message: e.message });
        }
    }
    voiceRooms = new Map();
    async handleVoiceJoin(client, data) {
        const userId = client.data.userId;
        if (!userId)
            return;
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
        this.voiceRooms.get(channelId).set(userId, participant);
        const participants = Array.from(this.voiceRooms.get(channelId).values());
        client.emit('voice:participants', { channelId, participants });
        client.to(`voice:${channelId}`).emit('voice:user:joined', { channelId, participant });
        console.log(`🎙️ User ${userId} joined voice room ${channelId} (${participants.length} participants)`);
    }
    handleVoiceLeave(client, data) {
        const userId = client.data.userId;
        if (!userId)
            return;
        const channelId = data.channelId;
        client.leave(`voice:${channelId}`);
        if (this.voiceRooms.has(channelId)) {
            this.voiceRooms.get(channelId).delete(userId);
            if (this.voiceRooms.get(channelId).size === 0) {
                this.voiceRooms.delete(channelId);
            }
        }
        this.server.to(`voice:${channelId}`).emit('voice:user:left', { channelId, userId });
        console.log(`🔇 User ${userId} left voice room ${channelId}`);
    }
    handleVoiceToggleMic(client, data) {
        const userId = client.data.userId;
        if (!userId)
            return;
        const channelId = data.channelId;
        if (this.voiceRooms.has(channelId) && this.voiceRooms.get(channelId).has(userId)) {
            this.voiceRooms.get(channelId).get(userId).isMuted = data.isMuted;
        }
        this.server.to(`voice:${channelId}`).emit('voice:mic:toggled', {
            channelId,
            userId,
            isMuted: data.isMuted,
        });
    }
    cleanupVoiceRooms(userId) {
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
    sendToUser(userId, event, data) {
        this.server.to(`user:${userId}`).emit(event, data);
    }
    isUserOnline(userId) {
        return this.onlineUsers.has(userId);
    }
    getOnlineUserIds() {
        return Array.from(this.onlineUsers.keys());
    }
};
exports.ChatGateway = ChatGateway;
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", socket_io_1.Server)
], ChatGateway.prototype, "server", void 0);
__decorate([
    (0, websockets_1.SubscribeMessage)('message:send'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], ChatGateway.prototype, "handleSendMessage", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('conversation:join'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], ChatGateway.prototype, "handleJoinConversation", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('conversation:leave'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], ChatGateway.prototype, "handleLeaveConversation", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('message:typing'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], ChatGateway.prototype, "handleTyping", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('message:read'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], ChatGateway.prototype, "handleMarkRead", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('channel:join'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], ChatGateway.prototype, "handleJoinChannel", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('channel:leave'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], ChatGateway.prototype, "handleLeaveChannel", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('channel:message:send'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], ChatGateway.prototype, "handleSendChannelMessage", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('voice:join'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], ChatGateway.prototype, "handleVoiceJoin", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('voice:leave'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], ChatGateway.prototype, "handleVoiceLeave", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('voice:toggle-mic'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], ChatGateway.prototype, "handleVoiceToggleMic", null);
exports.ChatGateway = ChatGateway = __decorate([
    (0, websockets_1.WebSocketGateway)({
        cors: { origin: '*' },
        namespace: '/chat',
    }),
    __metadata("design:paramtypes", [chat_service_1.ChatService,
        jwt_1.JwtService,
        communities_service_1.CommunitiesService])
], ChatGateway);
//# sourceMappingURL=chat.gateway.js.map