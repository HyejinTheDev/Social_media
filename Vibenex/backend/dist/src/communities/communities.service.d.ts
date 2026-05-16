import { PrismaService } from '../prisma/prisma.service';
export declare class CommunitiesService {
    private prisma;
    constructor(prisma: PrismaService);
    findAll(page: number, limit: number, search?: string): Promise<{
        communities: {
            id: string;
            name: string;
            createdAt: Date;
            updatedAt: Date;
            slug: string;
            description: string | null;
            icon: string | null;
            banner: string | null;
            isPublic: boolean;
            memberCount: number;
        }[];
        total: number;
    }>;
    findById(id: string): Promise<{
        id: string;
        name: string;
        createdAt: Date;
        updatedAt: Date;
        slug: string;
        description: string | null;
        icon: string | null;
        banner: string | null;
        isPublic: boolean;
        memberCount: number;
    }>;
    create(userId: string, data: {
        name: string;
        description?: string;
        isPublic?: boolean;
    }): Promise<{
        channels: {
            id: string;
            name: string;
            createdAt: Date;
            description: string | null;
            type: import("@prisma/client").$Enums.ChannelType;
            position: number;
            communityId: string;
        }[];
    } & {
        id: string;
        name: string;
        createdAt: Date;
        updatedAt: Date;
        slug: string;
        description: string | null;
        icon: string | null;
        banner: string | null;
        isPublic: boolean;
        memberCount: number;
    }>;
    getChannels(communityId: string): Promise<{
        id: string;
        name: string;
        createdAt: Date;
        description: string | null;
        type: import("@prisma/client").$Enums.ChannelType;
        position: number;
        communityId: string;
    }[]>;
    join(communityId: string, userId: string): Promise<{
        id: string;
        communityId: string;
        userId: string;
        role: import("@prisma/client").$Enums.CommunityRole;
        joinedAt: Date;
    }>;
    getChannelMessages(channelId: string, page: number, limit: number): Promise<{
        data: ({
            sender: {
                id: string;
                name: string;
                username: string;
                avatar: string | null;
            };
        } & {
            id: string;
            createdAt: Date;
            content: string;
            channelId: string;
            imageUrl: string | null;
            senderId: string;
        })[];
        meta: {
            total: number;
            page: number;
            limit: number;
            totalPages: number;
        };
    }>;
    sendChannelMessage(channelId: string, senderId: string, content: string, imageUrl?: string): Promise<{
        sender: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        content: string;
        channelId: string;
        imageUrl: string | null;
        senderId: string;
    }>;
}
