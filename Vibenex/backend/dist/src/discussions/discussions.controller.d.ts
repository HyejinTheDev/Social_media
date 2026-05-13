import { DiscussionsService } from './discussions.service';
export declare class DiscussionsController {
    private readonly discussionsService;
    constructor(discussionsService: DiscussionsService);
    findByChannel(channelId: string, page?: string, limit?: string): Promise<{
        discussions: ({
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
            linkUrl: string | null;
            isPinned: boolean;
            replyCount: number;
            reactionCount: number;
            channelId: string;
            authorId: string;
        })[];
        total: number;
    }>;
    create(req: any, channelId: string, body: {
        content: string;
        imageUrls?: string[];
        linkUrl?: string;
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
        linkUrl: string | null;
        isPinned: boolean;
        replyCount: number;
        reactionCount: number;
        channelId: string;
        authorId: string;
    }>;
    findOne(id: string): Promise<{
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
        linkUrl: string | null;
        isPinned: boolean;
        replyCount: number;
        reactionCount: number;
        channelId: string;
        authorId: string;
    }>;
    getReplies(discussionId: string): Promise<({
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
        discussionId: string;
    })[]>;
    createReply(req: any, discussionId: string, body: {
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
        discussionId: string;
    }>;
}
