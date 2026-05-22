import { PrismaService } from '../prisma/prisma.service';
export declare class CommunitiesService {
    private prisma;
    constructor(prisma: PrismaService);
    findAll(page: number, limit: number, search?: string): Promise<{
        communities: {
            participantAvatars: string[];
            participantNames: string[];
            id: string;
            name: string;
            slug: string;
            description: string | null;
            icon: string | null;
            banner: string | null;
            isPublic: boolean;
            isVoiceRoom: boolean;
            memberCount: number;
            createdAt: Date;
            updatedAt: Date;
        }[];
        total: number;
    }>;
    findById(id: string): Promise<{
        id: string;
        name: string;
        slug: string;
        description: string | null;
        icon: string | null;
        banner: string | null;
        isPublic: boolean;
        isVoiceRoom: boolean;
        memberCount: number;
        createdAt: Date;
        updatedAt: Date;
    }>;
    create(userId: string, data: {
        name: string;
        description?: string;
        isPublic?: boolean;
        isVoiceRoom?: boolean;
    }): Promise<{
        channels: {
            id: string;
            name: string;
            description: string | null;
            createdAt: Date;
            communityId: string;
            type: import("@prisma/client").$Enums.ChannelType;
            position: number;
        }[];
    } & {
        id: string;
        name: string;
        slug: string;
        description: string | null;
        icon: string | null;
        banner: string | null;
        isPublic: boolean;
        isVoiceRoom: boolean;
        memberCount: number;
        createdAt: Date;
        updatedAt: Date;
    }>;
    getChannels(communityId: string): Promise<{
        id: string;
        name: string;
        description: string | null;
        createdAt: Date;
        communityId: string;
        type: import("@prisma/client").$Enums.ChannelType;
        position: number;
    }[]>;
    join(communityId: string, userId: string): Promise<{
        id: string;
        role: import("@prisma/client").$Enums.CommunityRole;
        communityId: string;
        userId: string;
        joinedAt: Date;
    }>;
    leave(communityId: string, userId: string): Promise<{
        message: string;
    }>;
    update(communityId: string, userId: string, data: {
        name?: string;
        description?: string;
        isVoiceRoom?: boolean;
    }): Promise<{
        id: string;
        name: string;
        slug: string;
        description: string | null;
        icon: string | null;
        banner: string | null;
        isPublic: boolean;
        isVoiceRoom: boolean;
        memberCount: number;
        createdAt: Date;
        updatedAt: Date;
    }>;
    remove(communityId: string, userId: string): Promise<{
        message: string;
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
            channelId: string;
            senderId: string;
            content: string;
            imageUrl: string | null;
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
        channelId: string;
        senderId: string;
        content: string;
        imageUrl: string | null;
    }>;
}
