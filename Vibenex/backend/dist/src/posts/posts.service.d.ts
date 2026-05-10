import { PrismaService } from '../prisma/prisma.service';
import { CreatePostDto } from './dto/create-post.dto';
import { NotificationsService } from '../notifications/notifications.service';
export declare class PostsService {
    private prisma;
    private notificationsService;
    constructor(prisma: PrismaService, notificationsService: NotificationsService);
    create(userId: string, dto: CreatePostDto, fileUrls: {
        images?: string[];
        video?: string;
        thumbnail?: string;
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
        content: string;
        imageUrls: string[];
        videoUrl: string | null;
        videoThumbnailUrl: string | null;
        mediaType: import("@prisma/client").$Enums.MediaType;
        likesCount: number;
        commentsCount: number;
        sharesCount: number;
        createdAt: Date;
        updatedAt: Date;
        authorId: string;
    }>;
    getFeed(page?: number, limit?: number): Promise<{
        posts: ({
            author: {
                id: string;
                name: string;
                username: string;
                avatar: string | null;
                isVerified: boolean;
            };
        } & {
            id: string;
            content: string;
            imageUrls: string[];
            videoUrl: string | null;
            videoThumbnailUrl: string | null;
            mediaType: import("@prisma/client").$Enums.MediaType;
            likesCount: number;
            commentsCount: number;
            sharesCount: number;
            createdAt: Date;
            updatedAt: Date;
            authorId: string;
        })[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    getPostById(id: string): Promise<{
        author: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
    } & {
        id: string;
        content: string;
        imageUrls: string[];
        videoUrl: string | null;
        videoThumbnailUrl: string | null;
        mediaType: import("@prisma/client").$Enums.MediaType;
        likesCount: number;
        commentsCount: number;
        sharesCount: number;
        createdAt: Date;
        updatedAt: Date;
        authorId: string;
    }>;
    getUserPosts(userId: string, page?: number, limit?: number): Promise<{
        posts: ({
            author: {
                id: string;
                name: string;
                username: string;
                avatar: string | null;
                isVerified: boolean;
            };
        } & {
            id: string;
            content: string;
            imageUrls: string[];
            videoUrl: string | null;
            videoThumbnailUrl: string | null;
            mediaType: import("@prisma/client").$Enums.MediaType;
            likesCount: number;
            commentsCount: number;
            sharesCount: number;
            createdAt: Date;
            updatedAt: Date;
            authorId: string;
        })[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    remove(userId: string, postId: string): Promise<{
        success: boolean;
        message: string;
    }>;
    toggleLike(userId: string, postId: string): Promise<{
        liked: boolean;
    }>;
    getLikeStatus(userId: string, postId: string): Promise<{
        liked: boolean;
    }>;
}
