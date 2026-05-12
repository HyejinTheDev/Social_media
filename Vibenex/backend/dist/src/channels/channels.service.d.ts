import { PrismaService } from '../prisma/prisma.service';
export declare class ChannelsService {
    private prisma;
    constructor(prisma: PrismaService);
    findByCommunity(communityId: string): Promise<{
        type: import("@prisma/client").$Enums.ChannelType;
        description: string | null;
        name: string;
        id: string;
        createdAt: Date;
        position: number;
        communityId: string;
    }[]>;
    findById(id: string): Promise<{
        type: import("@prisma/client").$Enums.ChannelType;
        description: string | null;
        name: string;
        id: string;
        createdAt: Date;
        position: number;
        communityId: string;
    }>;
    create(communityId: string, data: {
        name: string;
        type?: string;
        description?: string;
    }): Promise<{
        type: import("@prisma/client").$Enums.ChannelType;
        description: string | null;
        name: string;
        id: string;
        createdAt: Date;
        position: number;
        communityId: string;
    }>;
}
