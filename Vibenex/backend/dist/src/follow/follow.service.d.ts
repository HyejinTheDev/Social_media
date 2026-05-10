import { PrismaService } from '../prisma/prisma.service';
import { NotificationsService } from '../notifications/notifications.service';
export declare class FollowService {
    private prisma;
    private notificationsService;
    constructor(prisma: PrismaService, notificationsService: NotificationsService);
    private readonly userSelect;
    follow(followerId: string, followingId: string): Promise<{
        following: boolean;
        message: string;
    } | {
        following: boolean;
        message?: undefined;
    }>;
    unfollow(followerId: string, followingId: string): Promise<{
        following: boolean;
        message: string;
    } | {
        following: boolean;
        message?: undefined;
    }>;
    getFollowStatus(followerId: string, followingId: string): Promise<{
        following: boolean;
    }>;
    getFollowers(userId: string, page?: number, limit?: number): Promise<{
        users: {
            id: string;
            name: string;
            username: string;
            bio: string | null;
            avatar: string | null;
            followersCount: number;
            followingCount: number;
            isVerified: boolean;
        }[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    getFollowing(userId: string, page?: number, limit?: number): Promise<{
        users: {
            id: string;
            name: string;
            username: string;
            bio: string | null;
            avatar: string | null;
            followersCount: number;
            followingCount: number;
            isVerified: boolean;
        }[];
        total: number;
        page: number;
        totalPages: number;
    }>;
}
