import { StoriesService } from './stories.service';
import { CreateStoryDto } from './dto/create-story.dto';
export declare class StoriesController {
    private readonly storiesService;
    constructor(storiesService: StoriesService);
    create(req: any, dto: CreateStoryDto, file: Express.Multer.File): Promise<{
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
    getActiveStories(req: any): Promise<{
        groups: {
            author: any;
            stories: any[];
            hasUnviewed: boolean;
            latestCreatedAt: Date;
        }[];
    }>;
    viewStory(req: any, id: string): Promise<{
        success: boolean;
        selfView: boolean;
    } | {
        success: boolean;
        selfView?: undefined;
    }>;
    deleteStory(req: any, id: string): Promise<{
        success: boolean;
        message: string;
    }>;
    getMyStories(req: any): Promise<{
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
