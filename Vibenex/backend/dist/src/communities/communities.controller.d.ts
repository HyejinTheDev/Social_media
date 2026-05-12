import { CommunitiesService } from './communities.service';
export declare class CommunitiesController {
    private readonly communitiesService;
    constructor(communitiesService: CommunitiesService);
    findAll(page?: string, limit?: string, search?: string): Promise<{
        communities: {
            description: string | null;
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            slug: string;
            icon: string | null;
            banner: string | null;
            isPublic: boolean;
            memberCount: number;
        }[];
        total: number;
    }>;
    findOne(id: string): Promise<{
        description: string | null;
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        slug: string;
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
            type: import("@prisma/client").$Enums.ChannelType;
            description: string | null;
            name: string;
            id: string;
            createdAt: Date;
            position: number;
            communityId: string;
        }[];
    } & {
        description: string | null;
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        slug: string;
        icon: string | null;
        banner: string | null;
        isPublic: boolean;
        memberCount: number;
    }>;
    getChannels(communityId: string): Promise<{
        type: import("@prisma/client").$Enums.ChannelType;
        description: string | null;
        name: string;
        id: string;
        createdAt: Date;
        position: number;
        communityId: string;
    }[]>;
    join(req: any, communityId: string): Promise<{
        id: string;
        userId: string;
        role: import("@prisma/client").$Enums.CommunityRole;
        joinedAt: Date;
        communityId: string;
    }>;
}
