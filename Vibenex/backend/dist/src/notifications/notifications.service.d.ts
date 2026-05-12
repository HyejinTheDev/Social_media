import { PrismaService } from '../prisma/prisma.service';
import { NotificationType } from '@prisma/client';
export declare class NotificationsService {
    private prisma;
    constructor(prisma: PrismaService);
    createNotification(userId: string, type: NotificationType, title: string, body: string, data?: any): Promise<{
        type: import("@prisma/client").$Enums.NotificationType;
        title: string;
        id: string;
        createdAt: Date;
        data: import("@prisma/client/runtime/client").JsonValue | null;
        userId: string;
        isRead: boolean;
        body: string;
    }>;
    getNotifications(userId: string, page?: number, limit?: number): Promise<{
        notifications: {
            type: import("@prisma/client").$Enums.NotificationType;
            title: string;
            id: string;
            createdAt: Date;
            data: import("@prisma/client/runtime/client").JsonValue | null;
            userId: string;
            isRead: boolean;
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
