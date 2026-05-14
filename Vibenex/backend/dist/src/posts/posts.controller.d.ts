import { PostsService } from './posts.service';
export declare class PostsController {
    private readonly postsService;
    constructor(postsService: PostsService);
    getFeed(page?: string, limit?: string): Promise<{
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
    getUserPosts(userId: string, page?: string, limit?: string): Promise<{
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
    createPost(req: any, body: {
        content: string;
        imageUrls?: string[];
        videoUrl?: string;
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
        content: string;
        imageUrls: string[];
        authorId: string;
        videoUrl: string | null;
        likeCount: number;
        commentCount: number;
        shareCount: number;
    }>;
    uploadMedia(file: Express.Multer.File): {
        url: string;
        type: string;
    };
    deletePost(req: any, id: string): Promise<{
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
        postId: string;
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
        postId: string;
    }>;
}
