import { ShortsService } from './shorts.service';
export declare class ShortsController {
    private readonly shortsService;
    constructor(shortsService: ShortsService);
    getFeed(page?: string, limit?: string): Promise<{
        data: ({
            _count: {
                comments: number;
                likes: number;
            };
            author: {
                id: string;
                name: string;
                username: string;
                avatar: string | null;
            };
            likes: {
                id: string;
                createdAt: Date;
                userId: string;
                shortId: string;
            }[];
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
        meta: {
            total: number;
            page: number;
            limit: number;
            totalPages: number;
        };
    }>;
    getShortById(id: string): Promise<{
        _count: {
            comments: number;
            likes: number;
        };
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
    }>;
    createShort(req: any, body: {
        videoUrl: string;
        caption?: string;
        thumbnailUrl?: string;
    }): Promise<{
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
    }>;
    toggleLike(req: any, id: string): Promise<{
        liked: boolean;
    }>;
    getComments(id: string): Promise<({
        author: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        content: string;
        authorId: string;
        parentId: string | null;
        shortId: string;
    })[]>;
    createComment(req: any, id: string, body: {
        content: string;
        parentId?: string;
    }): Promise<{
        author: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        content: string;
        authorId: string;
        parentId: string | null;
        shortId: string;
    }>;
}
