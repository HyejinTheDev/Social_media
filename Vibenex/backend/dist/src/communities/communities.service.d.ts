import { PrismaService } from '../prisma/prisma.service';
export declare class CommunitiesService {
    private prisma;
    constructor(prisma: PrismaService);
    findAll(page: number, limit: number, search?: string): Promise<{
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
    findById(id: string): Promise<{
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
    create(userId: string, data: {
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
    join(communityId: string, userId: string): Promise<{
        id: string;
        userId: string;
        role: import("@prisma/client").$Enums.CommunityRole;
        joinedAt: Date;
        communityId: string;
    }>;
}
