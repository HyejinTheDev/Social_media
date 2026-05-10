import { PrismaService } from '../prisma/prisma.service';
import { CreateStoryDto } from './dto/create-story.dto';
import { MediaType } from '@prisma/client';
export declare class StoriesService {
    private prisma;
    constructor(prisma: PrismaService);
    private readonly authorSelect;
    create(userId: string, dto: CreateStoryDto, fileUrl: string, mediaType: MediaType): Promise<{
        author: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
            isVerified: boolean;
        };
    } & {
        id: string;
        createdAt: Date;
        mediaType: import("@prisma/client").$Enums.MediaType;
        authorId: string;
        caption: string | null;
        mediaUrl: string;
        viewCount: number;
        expiresAt: Date;
    }>;
    getActiveStories(currentUserId: string): Promise<{
        groups: {
            author: any;
            stories: any[];
            hasUnviewed: boolean;
            latestCreatedAt: Date;
        }[];
    }>;
    viewStory(userId: string, storyId: string): Promise<{
        success: boolean;
        selfView: boolean;
    } | {
        success: boolean;
        selfView?: undefined;
    }>;
    deleteStory(userId: string, storyId: string): Promise<{
        success: boolean;
        message: string;
    }>;
    getMyStories(userId: string): Promise<{
        stories: ({
            views: ({
                viewer: {
                    name: string;
                    username: string;
                    id: string;
                    avatar: string | null;
                    isVerified: boolean;
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
            mediaType: import("@prisma/client").$Enums.MediaType;
            authorId: string;
            caption: string | null;
            mediaUrl: string;
            viewCount: number;
            expiresAt: Date;
        })[];
    }>;
}
