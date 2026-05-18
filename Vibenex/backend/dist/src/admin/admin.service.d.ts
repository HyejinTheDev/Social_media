import { PrismaService } from '../prisma/prisma.service';
export declare class AdminService {
    private prisma;
    constructor(prisma: PrismaService);
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
    getUsers(page?: number, limit?: number, search?: string): Promise<{
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
    deleteUser(userId: string): Promise<{
        message: string;
    }>;
    toggleVerify(userId: string): Promise<{
        isVerified: boolean;
    }>;
    getPosts(page?: number, limit?: number, search?: string): Promise<{
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
    deletePost(postId: string): Promise<{
        message: string;
    }>;
    getShorts(page?: number, limit?: number): Promise<{
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
    deleteShort(shortId: string): Promise<{
        message: string;
    }>;
    getCommunities(page?: number, limit?: number, search?: string): Promise<{
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
    deleteCommunity(communityId: string): Promise<{
        message: string;
    }>;
}
