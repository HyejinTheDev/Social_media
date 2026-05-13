import { PrismaService } from '../prisma/prisma.service';
export declare class DiscussionsService {
    private prisma;
    constructor(prisma: PrismaService);
    findByChannel(channelId: string, page: number, limit: number): Promise<{
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
    findById(id: string): Promise<{
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
    create(channelId: string, authorId: string, data: {
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
    createReply(discussionId: string, authorId: string, data: {
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
