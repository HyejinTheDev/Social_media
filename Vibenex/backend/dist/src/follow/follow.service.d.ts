import { PrismaService } from '../prisma/prisma.service';
export declare class FollowService {
    private prisma;
    constructor(prisma: PrismaService);
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
            name: string;
            username: string;
            id: string;
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
            name: string;
            username: string;
            id: string;
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
