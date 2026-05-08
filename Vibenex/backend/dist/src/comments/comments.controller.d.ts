import { CommentsService } from './comments.service';
import { CreateCommentDto } from './dto/create-comment.dto';
export declare class CommentsController {
    private readonly commentsService;
    constructor(commentsService: CommentsService);
    create(req: any, postId: string, createCommentDto: CreateCommentDto): Promise<{
        author: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        content: string;
        authorId: string;
        postId: string;
    }>;
    getComments(postId: string, page?: string, limit?: string): Promise<{
        comments: ({
            author: {
                name: string;
                username: string;
                id: string;
                avatar: string | null;
            };
        } & {
            id: string;
            createdAt: Date;
            content: string;
            authorId: string;
            postId: string;
        })[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    remove(req: any, id: string): Promise<{
        success: boolean;
        message: string;
    }>;
}
