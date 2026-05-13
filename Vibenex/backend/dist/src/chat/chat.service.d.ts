import { PrismaService } from '../prisma/prisma.service';
export declare class ChatService {
    private prisma;
    constructor(prisma: PrismaService);
    private readonly userSelect;
    getOrCreateConversation(userId1: string, userId2: string): Promise<{
        otherUser: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
        participant1: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
        participant2: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
        id: string;
        createdAt: Date;
        updatedAt: Date;
        lastMessage: string | null;
        lastMessageAt: Date | null;
        participant1Id: string;
        participant2Id: string;
    }>;
    getConversations(userId: string): Promise<{
        otherUser: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
        participant1: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
        participant2: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
        id: string;
        createdAt: Date;
        updatedAt: Date;
        lastMessage: string | null;
        lastMessageAt: Date | null;
        participant1Id: string;
        participant2Id: string;
    }[]>;
    getMessages(conversationId: string, userId: string, page?: number, limit?: number): Promise<{
        messages: ({
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
        })[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    sendMessage(conversationId: string, senderId: string, content: string, imageUrl?: string): Promise<{
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
    }>;
    markAsRead(conversationId: string, userId: string): Promise<{
        success: boolean;
    }>;
    getUnreadCount(conversationId: string, userId: string): Promise<{
        unreadCount: number;
    }>;
    deleteMessage(messageId: string, userId: string): Promise<{
        success: boolean;
    }>;
}
