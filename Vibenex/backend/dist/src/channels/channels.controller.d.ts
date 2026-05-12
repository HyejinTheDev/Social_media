import { ChannelsService } from './channels.service';
export declare class ChannelsController {
    private readonly channelsService;
    constructor(channelsService: ChannelsService);
    findOne(id: string): Promise<{
        type: import("@prisma/client").$Enums.ChannelType;
        description: string | null;
        name: string;
        id: string;
        createdAt: Date;
        position: number;
        communityId: string;
    }>;
}
