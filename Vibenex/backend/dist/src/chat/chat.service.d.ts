import { PrismaService } from '../prisma/prisma.service';
export declare class ChatService {
    private prisma;
    constructor(prisma: PrismaService);
    private readonly userSelect;
    getOrCreateConversation(userId1: string, userId2: string): Promise<{
        otherUser: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
            isVerified: boolean;
        };
        participant1: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
            isVerified: boolean;
        };
        participant2: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
            isVerified: boolean;
        };
        id: string;
        createdAt: Date;
        updatedAt: Date;
        participant1Id: string;
        participant2Id: string;
        lastMessage: string | null;
        lastMessageAt: Date | null;
    }>;
    getConversations(userId: string): Promise<{
        otherUser: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
            isVerified: boolean;
        };
        participant1: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
            isVerified: boolean;
        };
        participant2: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
            isVerified: boolean;
        };
        id: string;
        createdAt: Date;
        updatedAt: Date;
        participant1Id: string;
        participant2Id: string;
        lastMessage: string | null;
        lastMessageAt: Date | null;
    }[]>;
    getMessages(conversationId: string, userId: string, page?: number, limit?: number): Promise<{
        messages: ({
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
        })[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    sendMessage(conversationId: string, senderId: string, content: string, imageUrl?: string): Promise<{
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
