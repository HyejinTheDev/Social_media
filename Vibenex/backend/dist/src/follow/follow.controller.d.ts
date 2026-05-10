import { FollowService } from './follow.service';
export declare class FollowController {
    private readonly followService;
    constructor(followService: FollowService);
    follow(req: any, userId: string): Promise<{
        following: boolean;
        message: string;
    } | {
        following: boolean;
        message?: undefined;
    }>;
    unfollow(req: any, userId: string): Promise<{
        following: boolean;
        message: string;
    } | {
        following: boolean;
        message?: undefined;
    }>;
    getStatus(req: any, userId: string): Promise<{
        following: boolean;
    }>;
    getFollowers(userId: string, page?: string): Promise<{
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
    getFollowing(userId: string, page?: string): Promise<{
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
