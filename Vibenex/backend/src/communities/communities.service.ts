import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class CommunitiesService {
  constructor(private prisma: PrismaService) {}

  async findAll(page: number, limit: number, search?: string) {
    const where = search
      ? {
          OR: [
            { name: { contains: search, mode: 'insensitive' as const } },
            { description: { contains: search, mode: 'insensitive' as const } },
          ],
        }
      : {};

    const [communities, total] = await Promise.all([
      this.prisma.community.findMany({
        where,
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { createdAt: 'desc' },
      }),
      this.prisma.community.count({ where }),
    ]);

    return { communities, total };
  }

  async findById(id: string) {
    const community = await this.prisma.community.findUnique({ where: { id } });
    if (!community) throw new NotFoundException('Community not found');
    return community;
  }

  async create(userId: string, data: { name: string; description?: string; isPublic?: boolean }) {
    const slug = data.name
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-|-$/g, '')
      + '-' + Date.now().toString(36);

    const community = await this.prisma.community.create({
      data: {
        name: data.name,
        slug,
        description: data.description,
        isPublic: data.isPublic ?? true,
        memberCount: 1,
        members: {
          create: {
            userId,
            role: 'OWNER',
          },
        },
        channels: {
          create: {
            name: 'general',
            type: 'TEXT',
            description: 'General discussion',
            position: 0,
          },
        },
      },
      include: {
        channels: true,
      },
    });

    return community;
  }

  async getChannels(communityId: string) {
    const community = await this.prisma.community.findUnique({ where: { id: communityId } });
    if (!community) throw new NotFoundException('Community not found');

    return this.prisma.channel.findMany({
      where: { communityId },
      orderBy: { position: 'asc' },
    });
  }

  async join(communityId: string, userId: string) {
    const community = await this.prisma.community.findUnique({ where: { id: communityId } });
    if (!community) throw new NotFoundException('Community not found');
    if (!community.isPublic) throw new ForbiddenException('This community is private');

    const existing = await this.prisma.communityMember.findUnique({
      where: { communityId_userId: { communityId, userId } },
    });
    if (existing) return existing;

    const member = await this.prisma.communityMember.create({
      data: { communityId, userId, role: 'MEMBER' },
    });

    await this.prisma.community.update({
      where: { id: communityId },
      data: { memberCount: { increment: 1 } },
    });

    return member;
  }
}
