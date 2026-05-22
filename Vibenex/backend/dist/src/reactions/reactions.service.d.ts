import { PrismaService } from '../prisma/prisma.service';
export declare class ReactionsService {
    private prisma;
    constructor(prisma: PrismaService);
    toggleDiscussionReaction(discussionId: string, userId: string, emoji: string): Promise<{
        reacted: boolean;
        emoji: string;
    }>;
    toggleReplyReaction(replyId: string, userId: string, emoji: string): Promise<{
        reacted: boolean;
        emoji: string;
    }>;
    getDiscussionReactions(discussionId: string, userId?: string): Promise<{
        emoji: string;
        count: number;
        reacted: boolean;
        users: any[];
    }[]>;
    getReplyReactions(replyId: string, userId?: string): Promise<{
        emoji: string;
        count: number;
        reacted: boolean;
        users: any[];
    }[]>;
    private groupReactions;
}
