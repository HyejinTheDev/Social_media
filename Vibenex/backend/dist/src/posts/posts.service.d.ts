import { PrismaService } from '../prisma/prisma.service';
import { NotificationsService } from '../notifications/notifications.service';
export declare class PostsService {
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
                postId: string;
            }[];
            _count: {
                comments: number;
                likes: number;
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
        meta: {
            total: number;
            page: number;
            limit: number;
            totalPages: number;
        };
    }>;
    getUserPosts(userId: string, page: number, limit: number): Promise<{
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
                postId: string;
            }[];
            _count: {
                comments: number;
                likes: number;
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
        meta: {
            total: number;
            page: number;
            limit: number;
            totalPages: number;
        };
    }>;
    createPost(authorId: string, content: string, imageUrls?: string[], videoUrl?: string): Promise<{
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
    }>;
    getPostById(id: string): Promise<{
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
        content: string;
        imageUrls: string[];
        authorId: string;
        videoUrl: string | null;
        likeCount: number;
        commentCount: number;
        shareCount: number;
    }>;
    deletePost(id: string, authorId: string): Promise<{
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
    }>;
    toggleLike(postId: string, userId: string): Promise<{
        liked: boolean;
    }>;
    getComments(postId: string): Promise<({
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
        postId: string;
    })[]>;
    createComment(postId: string, authorId: string, content: string, parentId?: string): Promise<{
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
        postId: string;
    }>;
}
