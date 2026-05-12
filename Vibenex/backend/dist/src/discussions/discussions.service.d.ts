import { PrismaService } from '../prisma/prisma.service';
export declare class DiscussionsService {
    private prisma;
    constructor(prisma: PrismaService);
    findByChannel(channelId: string, page: number, limit: number): Promise<{
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
    findById(id: string): Promise<{
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
    create(channelId: string, authorId: string, data: {
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
    createReply(discussionId: string, authorId: string, data: {
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
