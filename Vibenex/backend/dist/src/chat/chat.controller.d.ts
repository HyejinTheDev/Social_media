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
        createdAt: Date;
        updatedAt: Date;
        lastMessage: string | null;
        lastMessageAt: Date | null;
        participant1Id: string;
        participant2Id: string;
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
        createdAt: Date;
        updatedAt: Date;
        lastMessage: string | null;
        lastMessageAt: Date | null;
        participant1Id: string;
        participant2Id: string;
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
        content: string;
        imageUrl: string | null;
        isRead: boolean;
        senderId: string;
        conversationId: string;
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
