import { CommunitiesService } from './communities.service';
export declare class CommunitiesController {
    private readonly communitiesService;
    constructor(communitiesService: CommunitiesService);
    findAll(page?: string, limit?: string, search?: string): Promise<{
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
            isVoiceRoom: boolean;
            memberCount: number;
        }[];
        total: number;
    }>;
    findOne(id: string): Promise<{
        id: string;
        name: string;
        createdAt: Date;
        updatedAt: Date;
        slug: string;
        description: string | null;
        icon: string | null;
        banner: string | null;
        isPublic: boolean;
        isVoiceRoom: boolean;
        memberCount: number;
    }>;
    create(req: any, body: {
        name: string;
        description?: string;
        isPublic?: boolean;
        isVoiceRoom?: boolean;
    }): Promise<{
        channels: {
            id: string;
            name: string;
            createdAt: Date;
            description: string | null;
            communityId: string;
            type: import("@prisma/client").$Enums.ChannelType;
            position: number;
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
        isVoiceRoom: boolean;
        memberCount: number;
    }>;
    getChannels(communityId: string): Promise<{
        id: string;
        name: string;
        createdAt: Date;
        description: string | null;
        communityId: string;
        type: import("@prisma/client").$Enums.ChannelType;
        position: number;
    }[]>;
    join(req: any, communityId: string): Promise<{
        id: string;
        role: import("@prisma/client").$Enums.CommunityRole;
        joinedAt: Date;
        userId: string;
        communityId: string;
    }>;
    leave(req: any, communityId: string): Promise<{
        message: string;
    }>;
    update(req: any, id: string, body: {
        name?: string;
        description?: string;
        isVoiceRoom?: boolean;
    }): Promise<{
        id: string;
        name: string;
        createdAt: Date;
        updatedAt: Date;
        slug: string;
        description: string | null;
        icon: string | null;
        banner: string | null;
        isPublic: boolean;
        isVoiceRoom: boolean;
        memberCount: number;
    }>;
    remove(req: any, id: string): Promise<{
        message: string;
    }>;
    getChannelMessages(channelId: string, page?: string, limit?: string): Promise<{
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
}
