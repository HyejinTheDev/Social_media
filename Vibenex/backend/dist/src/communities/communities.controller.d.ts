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
        memberCount: number;
    }>;
    create(req: any, body: {
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
    join(req: any, communityId: string): Promise<{
        id: string;
        communityId: string;
        userId: string;
        role: import("@prisma/client").$Enums.CommunityRole;
        joinedAt: Date;
    }>;
}
