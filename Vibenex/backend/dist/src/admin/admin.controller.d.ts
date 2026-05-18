import { AdminService } from './admin.service';
export declare class AdminController {
    private adminService;
    constructor(adminService: AdminService);
    getStats(): Promise<{
        totalUsers: number;
        totalPosts: number;
        totalShorts: number;
        totalCommunities: number;
        totalMessages: number;
        totalStories: number;
        newUsers: number;
        dailyUsers: {
            date: Date;
            count: number;
        }[];
        dailyPosts: {
            date: Date;
            count: number;
        }[];
    }>;
    getUsers(page?: string, search?: string): Promise<{
        users: {
            id: string;
            email: string;
            name: string;
            username: string;
            avatar: string | null;
            reputation: number;
            isVerified: boolean;
            role: import("@prisma/client").$Enums.UserRole;
            createdAt: Date;
            _count: {
                posts: number;
                shorts: number;
            };
        }[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    deleteUser(id: string): Promise<{
        message: string;
    }>;
    toggleVerify(id: string): Promise<{
        isVerified: boolean;
    }>;
    getPosts(page?: string, search?: string): Promise<{
        posts: ({
            author: {
                id: string;
                name: string;
                username: string;
                avatar: string | null;
            };
        } & {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            content: string;
            imageUrls: string[];
            authorId: string;
            videoUrl: string | null;
            likeCount: number;
            commentCount: number;
            shareCount: number;
        })[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    deletePost(id: string): Promise<{
        message: string;
    }>;
    getShorts(page?: string): Promise<{
        shorts: ({
            author: {
                id: string;
                name: string;
                username: string;
                avatar: string | null;
            };
        } & {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            authorId: string;
            videoUrl: string;
            likeCount: number;
            commentCount: number;
            shareCount: number;
            caption: string | null;
            thumbnailUrl: string | null;
        })[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    deleteShort(id: string): Promise<{
        message: string;
    }>;
    getCommunities(page?: string, search?: string): Promise<{
        communities: ({
            _count: {
                channels: number;
                members: number;
            };
        } & {
            id: string;
            name: string;
            createdAt: Date;
            updatedAt: Date;
            slug: string;
            description: string | null;
            icon: string | null;
            banner: string | null;
            isPublic: boolean;
            isVoiceRoom: boolean;
            memberCount: number;
        })[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    deleteCommunity(id: string): Promise<{
        message: string;
    }>;
}
