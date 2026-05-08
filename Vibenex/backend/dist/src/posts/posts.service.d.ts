import { PrismaService } from '../prisma/prisma.service';
import { CreatePostDto } from './dto/create-post.dto';
export declare class PostsService {
    private prisma;
    constructor(prisma: PrismaService);
    create(userId: string, dto: CreatePostDto, fileUrls: {
        images?: string[];
        video?: string;
        thumbnail?: string;
    }): Promise<{
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
        updatedAt: Date;
        content: string;
        imageUrls: string[];
        videoUrl: string | null;
        videoThumbnailUrl: string | null;
        mediaType: import("@prisma/client").$Enums.MediaType;
        likesCount: number;
        commentsCount: number;
        sharesCount: number;
        authorId: string;
    }>;
    getFeed(page?: number, limit?: number): Promise<{
        posts: ({
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
            updatedAt: Date;
            content: string;
            imageUrls: string[];
            videoUrl: string | null;
            videoThumbnailUrl: string | null;
            mediaType: import("@prisma/client").$Enums.MediaType;
            likesCount: number;
            commentsCount: number;
            sharesCount: number;
            authorId: string;
        })[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    getPostById(id: string): Promise<{
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
        updatedAt: Date;
        content: string;
        imageUrls: string[];
        videoUrl: string | null;
        videoThumbnailUrl: string | null;
        mediaType: import("@prisma/client").$Enums.MediaType;
        likesCount: number;
        commentsCount: number;
        sharesCount: number;
        authorId: string;
    }>;
    getUserPosts(userId: string, page?: number, limit?: number): Promise<{
        posts: ({
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
            updatedAt: Date;
            content: string;
            imageUrls: string[];
            videoUrl: string | null;
            videoThumbnailUrl: string | null;
            mediaType: import("@prisma/client").$Enums.MediaType;
            likesCount: number;
            commentsCount: number;
            sharesCount: number;
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
