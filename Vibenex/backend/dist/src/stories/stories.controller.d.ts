import { StoriesService } from './stories.service';
export declare class StoriesController {
    private readonly storiesService;
    constructor(storiesService: StoriesService);
    getFeed(req: any): Promise<{
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
    getMyStories(req: any): Promise<({
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
    createStory(req: any, body: {
        imageUrl?: string;
        videoUrl?: string;
        caption?: string;
    }): Promise<{
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
    uploadMedia(file: Express.Multer.File): {
        url: string;
        type: string;
    };
    viewStory(req: any, id: string): Promise<{
        success: boolean;
    }>;
    deleteStory(req: any, id: string): Promise<{
        message: string;
    }>;
}
