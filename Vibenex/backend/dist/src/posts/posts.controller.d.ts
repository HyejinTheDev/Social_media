import { PostsService } from './posts.service';
import { CreatePostDto } from './dto/create-post.dto';
export declare class PostsController {
    private readonly postsService;
    constructor(postsService: PostsService);
    create(req: any, createPostDto: CreatePostDto, files: {
        images?: Express.Multer.File[];
        video?: Express.Multer.File[];
        thumbnail?: Express.Multer.File[];
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
    findAll(page?: string, limit?: string): Promise<{
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
    findByUser(userId: string, page?: string, limit?: string): Promise<{
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
    findOne(id: string): Promise<{
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
    remove(req: any, id: string): Promise<{
        success: boolean;
        message: string;
    }>;
    toggleLike(req: any, id: string): Promise<{
        liked: boolean;
    }>;
    getLikeStatus(req: any, id: string): Promise<{
        liked: boolean;
    }>;
}
