import { PrismaService } from '../prisma/prisma.service';
export declare class ChannelsService {
    private prisma;
    constructor(prisma: PrismaService);
    findByCommunity(communityId: string): Promise<{
        id: string;
        name: string;
        createdAt: Date;
        description: string | null;
        type: import("@prisma/client").$Enums.ChannelType;
        position: number;
        communityId: string;
    }[]>;
    findById(id: string): Promise<{
        id: string;
        name: string;
        createdAt: Date;
        description: string | null;
        type: import("@prisma/client").$Enums.ChannelType;
        position: number;
        communityId: string;
    }>;
    create(communityId: string, data: {
        name: string;
        type?: string;
        description?: string;
    }): Promise<{
        id: string;
        name: string;
        createdAt: Date;
        description: string | null;
        type: import("@prisma/client").$Enums.ChannelType;
        position: number;
        communityId: string;
    }>;
}
