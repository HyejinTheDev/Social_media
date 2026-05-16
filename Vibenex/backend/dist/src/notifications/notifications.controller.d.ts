import { NotificationsService } from './notifications.service';
export declare class NotificationsController {
    private readonly notificationsService;
    constructor(notificationsService: NotificationsService);
    getNotifications(req: any, page?: string): Promise<{
        notifications: {
            id: string;
            createdAt: Date;
            data: import("@prisma/client/runtime/client").JsonValue | null;
            userId: string;
            type: import("@prisma/client").$Enums.NotificationType;
            isRead: boolean;
            title: string;
            body: string;
        }[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    getUnreadCount(req: any): Promise<{
        unreadCount: number;
    }>;
    markAllAsRead(req: any): Promise<{
        success: boolean;
    }>;
    markAsRead(req: any, id: string): Promise<{
        success: boolean;
    }>;
}
