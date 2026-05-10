import { PrismaService } from '../prisma/prisma.service';
import { CreateCommentDto } from './dto/create-comment.dto';
import { NotificationsService } from '../notifications/notifications.service';
export declare class CommentsService {
    private prisma;
    private notificationsService;
    constructor(prisma: PrismaService, notificationsService: NotificationsService);
    create(userId: string, postId: string, dto: CreateCommentDto): Promise<{
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
    getComments(postId: string, page?: number, limit?: number): Promise<{
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
    remove(userId: string, id: string): Promise<{
        success: boolean;
        message: string;
    }>;
}
