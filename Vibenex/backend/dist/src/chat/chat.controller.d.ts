import { ChatService } from './chat.service';
export declare class ChatController {
    private readonly chatService;
    constructor(chatService: ChatService);
    getConversations(req: any): Promise<{
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
        participant1Id: string;
        participant2Id: string;
        lastMessage: string | null;
        lastMessageAt: Date | null;
        createdAt: Date;
        updatedAt: Date;
    }[]>;
    getOrCreateConversation(req: any, userId: string): Promise<{
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
        participant1Id: string;
        participant2Id: string;
        lastMessage: string | null;
        lastMessageAt: Date | null;
        createdAt: Date;
        updatedAt: Date;
    }>;
    getMessages(req: any, conversationId: string, page?: string): Promise<{
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
            conversationId: string;
            senderId: string;
            content: string;
            imageUrl: string | null;
            isRead: boolean;
        })[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    sendMessage(req: any, conversationId: string, body: {
        content: string;
        imageUrl?: string;
    }): Promise<{
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
        conversationId: string;
        senderId: string;
        content: string;
        imageUrl: string | null;
        isRead: boolean;
    }>;
    markAsRead(req: any, conversationId: string): Promise<{
        success: boolean;
    }>;
    getUnreadCount(req: any, conversationId: string): Promise<{
        unreadCount: number;
    }>;
    deleteMessage(req: any, messageId: string): Promise<{
        success: boolean;
    }>;
}
