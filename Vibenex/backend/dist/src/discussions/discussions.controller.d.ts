import { DiscussionsService } from './discussions.service';
export declare class DiscussionsController {
    private readonly discussionsService;
    constructor(discussionsService: DiscussionsService);
    findByChannel(channelId: string, page?: string, limit?: string): Promise<{
        discussions: ({
            author: {
                name: string;
                username: string;
                id: string;
                avatar: string | null;
            };
        } & {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            channelId: string;
            authorId: string;
            content: string;
            imageUrls: string[];
            linkUrl: string | null;
            isPinned: boolean;
            replyCount: number;
            reactionCount: number;
        })[];
        total: number;
    }>;
    create(req: any, channelId: string, body: {
        content: string;
        imageUrls?: string[];
        linkUrl?: string;
    }): Promise<{
        author: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        updatedAt: Date;
        channelId: string;
        authorId: string;
        content: string;
        imageUrls: string[];
        linkUrl: string | null;
        isPinned: boolean;
        replyCount: number;
        reactionCount: number;
    }>;
    findOne(id: string): Promise<{
        author: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        updatedAt: Date;
        channelId: string;
        authorId: string;
        content: string;
        imageUrls: string[];
        linkUrl: string | null;
        isPinned: boolean;
        replyCount: number;
        reactionCount: number;
    }>;
    getReplies(discussionId: string): Promise<({
        author: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        authorId: string;
        content: string;
        discussionId: string;
        parentId: string | null;
    })[]>;
    createReply(req: any, discussionId: string, body: {
        content: string;
        parentId?: string;
    }): Promise<{
        author: {
            name: string;
            username: string;
            id: string;
            avatar: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        authorId: string;
        content: string;
        discussionId: string;
        parentId: string | null;
    }>;
}
