import { StoriesService } from './stories.service';
export declare class StoriesController {
    private readonly storiesService;
    constructor(storiesService: StoriesService);
    getFeed(req: any): Promise<({
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
        expiresAt: Date;
    })[]>;
    createStory(req: any, body: {
        imageUrl?: string;
        videoUrl?: string;
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
        expiresAt: Date;
    }>;
}
