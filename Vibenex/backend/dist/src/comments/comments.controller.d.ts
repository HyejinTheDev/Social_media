import { CommentsService } from './comments.service';
import { CreateCommentDto } from './dto/create-comment.dto';
export declare class CommentsController {
    private readonly commentsService;
    constructor(commentsService: CommentsService);
    create(req: any, postId: string, createCommentDto: CreateCommentDto): Promise<{
        author: {
            name: string;
            id: string;
            username: string;
            avatar: string | null;
        };
    } & {
        id: string;
        postId: string;
        authorId: string;
        content: string;
        createdAt: Date;
    }>;
    getComments(postId: string, page?: string, limit?: string): Promise<{
        comments: ({
            author: {
                name: string;
                id: string;
                username: string;
                avatar: string | null;
            };
        } & {
            id: string;
            postId: string;
            authorId: string;
            content: string;
            createdAt: Date;
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
