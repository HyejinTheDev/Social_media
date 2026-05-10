import { OnGatewayConnection, OnGatewayDisconnect } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { JwtService } from '@nestjs/jwt';
import { ChatService } from './chat.service';
export declare class ChatGateway implements OnGatewayConnection, OnGatewayDisconnect {
    private chatService;
    private jwtService;
    server: Server;
    private onlineUsers;
    constructor(chatService: ChatService, jwtService: JwtService);
    handleConnection(client: Socket): Promise<void>;
    handleDisconnect(client: Socket): void;
    handleSendMessage(client: Socket, data: {
        conversationId: string;
        content: string;
        imageUrl?: string;
    }): Promise<({
        sender: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
            isVerified: boolean;
        };
    } & {
        id: string;
        createdAt: Date;
        content: string;
        conversationId: string;
        senderId: string;
        imageUrl: string | null;
        isRead: boolean;
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
    sendToUser(userId: string, event: string, data: any): void;
    isUserOnline(userId: string): boolean;
    getOnlineUserIds(): string[];
}
