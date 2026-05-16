import { PrismaService } from '../prisma/prisma.service';
import { NotificationsService } from '../notifications/notifications.service';
export declare class ShortsService {
    private prisma;
    private notificationsService;
    constructor(prisma: PrismaService, notificationsService: NotificationsService);
    getFeed(page: number, limit: number): Promise<{
        data: ({
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
            _count: {
                comments: number;
                likes: number;
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
        meta: {
            total: number;
            page: number;
            limit: number;
            totalPages: number;
        };
    }>;
    getShortById(id: string): Promise<{
        author: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
        };
        _count: {
            comments: number;
            likes: number;
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
    createShort(authorId: string, videoUrl: string, caption?: string, thumbnailUrl?: string): Promise<{
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
    toggleLike(shortId: string, userId: string): Promise<{
        liked: boolean;
    }>;
    getComments(shortId: string): Promise<({
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
    createComment(shortId: string, authorId: string, content: string, parentId?: string): Promise<{
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
