import { PrismaService } from '../prisma/prisma.service';
export declare class StoriesService {
    private prisma;
    constructor(prisma: PrismaService);
    createStory(userId: string, imageUrl?: string, videoUrl?: string, caption?: string): Promise<{
        author: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
    } & {
        id: string;
        createdAt: Date;
        authorId: string;
        imageUrl: string | null;
        videoUrl: string | null;
        caption: string | null;
        viewCount: number;
        expiresAt: Date;
    }>;
    getFeed(userId: string): Promise<{
        isViewed: boolean;
        views: undefined;
        author: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
        id: string;
        createdAt: Date;
        authorId: string;
        imageUrl: string | null;
        videoUrl: string | null;
        caption: string | null;
        viewCount: number;
        expiresAt: Date;
    }[]>;
    viewStory(storyId: string, viewerId: string): Promise<{
        success: boolean;
    }>;
    deleteStory(storyId: string, userId: string): Promise<{
        message: string;
    }>;
    getMyStories(userId: string): Promise<({
        views: ({
            viewer: {
                id: string;
                name: string;
                username: string;
                avatar: string | null;
            };
        } & {
            id: string;
            viewerId: string;
            storyId: string;
            viewedAt: Date;
        })[];
    } & {
        id: string;
        createdAt: Date;
        authorId: string;
        imageUrl: string | null;
        videoUrl: string | null;
        caption: string | null;
        viewCount: number;
        expiresAt: Date;
    })[]>;
}
