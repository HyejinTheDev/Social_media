import { PrismaService } from '../prisma/prisma.service';
import { NotificationType } from '@prisma/client';
import { ChatGateway } from '../chat/chat.gateway';
export declare class NotificationsService {
    private prisma;
    private chatGateway;
    constructor(prisma: PrismaService, chatGateway: ChatGateway);
    createNotification(userId: string, type: NotificationType, title: string, body: string, data?: any): Promise<{
        id: string;
        createdAt: Date;
        userId: string;
        data: import("@prisma/client/runtime/client").JsonValue | null;
        type: import("@prisma/client").$Enums.NotificationType;
        isRead: boolean;
        title: string;
        body: string;
    }>;
    getNotifications(userId: string, page?: number, limit?: number): Promise<{
        notifications: {
            id: string;
            createdAt: Date;
            userId: string;
            data: import("@prisma/client/runtime/client").JsonValue | null;
            type: import("@prisma/client").$Enums.NotificationType;
            isRead: boolean;
            title: string;
            body: string;
        }[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    getUnreadCount(userId: string): Promise<{
        unreadCount: number;
    }>;
    markAsRead(notificationId: string, userId: string): Promise<{
        success: boolean;
    }>;
    markAllAsRead(userId: string): Promise<{
        success: boolean;
    }>;
}
