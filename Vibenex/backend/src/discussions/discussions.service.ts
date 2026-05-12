import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class DiscussionsService {
  constructor(private prisma: PrismaService) {}

  async findByChannel(channelId: string, page: number, limit: number) {
    const where = { channelId };

    const [discussions, total] = await Promise.all([
      this.prisma.discussion.findMany({
        where,
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          author: {
            select: { id: true, name: true, username: true, avatar: true },
          },
        },
      }),
      this.prisma.discussion.count({ where }),
    ]);

    return { discussions, total };
  }

  async findById(id: string) {
    const discussion = await this.prisma.discussion.findUnique({
      where: { id },
      include: {
        author: {
          select: { id: true, name: true, username: true, avatar: true },
        },
      },
    });
    if (!discussion) throw new NotFoundException('Discussion not found');
    return discussion;
  }

  async create(
    channelId: string,
    authorId: string,
    data: { content: string; imageUrls?: string[]; linkUrl?: string },
  ) {
    // Verify channel exists
    const channel = await this.prisma.channel.findUnique({ where: { id: channelId } });
    if (!channel) throw new NotFoundException('Channel not found');

    return this.prisma.discussion.create({
      data: {
        channelId,
        authorId,
        content: data.content,
        imageUrls: data.imageUrls || [],
        linkUrl: data.linkUrl,
      },
      include: {
        author: {
          select: { id: true, name: true, username: true, avatar: true },
        },
      },
    });
  }

  async getReplies(discussionId: string) {
    const discussion = await this.prisma.discussion.findUnique({ where: { id: discussionId } });
    if (!discussion) throw new NotFoundException('Discussion not found');

    return this.prisma.reply.findMany({
      where: { discussionId },
      orderBy: { createdAt: 'asc' },
      include: {
        author: {
          select: { id: true, name: true, username: true, avatar: true },
        },
      },
    });
  }

  async createReply(
    discussionId: string,
    authorId: string,
    data: { content: string; parentId?: string },
  ) {
    const discussion = await this.prisma.discussion.findUnique({ where: { id: discussionId } });
    if (!discussion) throw new NotFoundException('Discussion not found');

    const reply = await this.prisma.reply.create({
      data: {
        discussionId,
        authorId,
        content: data.content,
        parentId: data.parentId,
      },
      include: {
        author: {
          select: { id: true, name: true, username: true, avatar: true },
        },
      },
    });

    // Increment reply count
    await this.prisma.discussion.update({
      where: { id: discussionId },
      data: { replyCount: { increment: 1 } },
    });

    return reply;
  }
}
