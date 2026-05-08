import { PrismaService } from '../prisma/prisma.service';
import { CreateCommentDto } from './dto/create-comment.dto';
export declare class CommentsService {
    private prisma;
    constructor(prisma: PrismaService);
    create(userId: string, postId: string, dto: CreateCommentDto): Promise<{
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
    getComments(postId: string, page?: number, limit?: number): Promise<{
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
    remove(userId: string, id: string): Promise<{
        success: boolean;
        message: string;
    }>;
}
