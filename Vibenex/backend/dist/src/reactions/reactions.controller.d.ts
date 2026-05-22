import { ReactionsService } from './reactions.service';
export declare class ReactionsController {
    private readonly reactionsService;
    constructor(reactionsService: ReactionsService);
    toggleDiscussionReaction(req: any, discussionId: string, body: {
        emoji: string;
    }): Promise<{
        reacted: boolean;
        emoji: string;
    }>;
    toggleReplyReaction(req: any, replyId: string, body: {
        emoji: string;
    }): Promise<{
        reacted: boolean;
        emoji: string;
    }>;
    getDiscussionReactions(req: any, discussionId: string): Promise<{
        emoji: string;
        count: number;
        reacted: boolean;
        users: any[];
    }[]>;
    getReplyReactions(req: any, replyId: string): Promise<{
        emoji: string;
        count: number;
        reacted: boolean;
        users: any[];
    }[]>;
}
