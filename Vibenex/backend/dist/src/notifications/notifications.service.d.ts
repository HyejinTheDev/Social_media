import { PrismaService } from '../prisma/prisma.service';
import { NotificationType } from '@prisma/client';
export declare class NotificationsService {
    private prisma;
    constructor(prisma: PrismaService);
    createNotification(userId: string, type: NotificationType, title: string, body: string, data?: any): Promise<{
        data: import("@prisma/client/runtime/client").JsonValue | null;
        id: string;
        type: import("@prisma/client").$Enums.NotificationType;
        title: string;
        body: string;
        isRead: boolean;
        createdAt: Date;
        userId: string;
    }>;
    getNotifications(userId: string, page?: number, limit?: number): Promise<{
        notifications: {
            data: import("@prisma/client/runtime/client").JsonValue | null;
            id: string;
            type: import("@prisma/client").$Enums.NotificationType;
            title: string;
            body: string;
            isRead: boolean;
            createdAt: Date;
            userId: string;
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
