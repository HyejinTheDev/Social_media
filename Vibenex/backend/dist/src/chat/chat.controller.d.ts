import { ChatService } from './chat.service';
export declare class ChatController {
    private readonly chatService;
    constructor(chatService: ChatService);
    getConversations(req: any): Promise<{
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
    getOrCreateConversation(req: any, userId: string): Promise<{
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
    getMessages(req: any, conversationId: string, page?: string): Promise<{
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
    sendMessage(req: any, conversationId: string, body: {
        content: string;
        imageUrl?: string;
    }): Promise<{
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
