import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ChannelsService {
  constructor(private prisma: PrismaService) {}

  async findByCommunity(communityId: string) {
    return this.prisma.channel.findMany({
      where: { communityId },
      orderBy: { position: 'asc' },
    });
  }

  async findById(id: string) {
    const channel = await this.prisma.channel.findUnique({ where: { id } });
    if (!channel) throw new NotFoundException('Channel not found');
    return channel;
  }

  async create(communityId: string, data: { name: string; type?: string; description?: string }) {
    const lastChannel = await this.prisma.channel.findFirst({
      where: { communityId },
      orderBy: { position: 'desc' },
    });

    return this.prisma.channel.create({
      data: {
        communityId,
        name: data.name,
        type: (data.type as any) || 'TEXT',
        description: data.description,
        position: (lastChannel?.position ?? -1) + 1,
      },
    });
  }
}
