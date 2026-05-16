import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { NotificationsService } from '../notifications/notifications.service';

@Injectable()
export class ShortsService {
  constructor(
    private prisma: PrismaService,
    private notificationsService: NotificationsService,
  ) {}

  async getFeed(page: number, limit: number) {
    const skip = (page - 1) * limit;
    
    const [shorts, total] = await Promise.all([
      this.prisma.short.findMany({
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          author: {
            select: { id: true, name: true, username: true, avatar: true }
          },
          likes: true,
          _count: {
            select: { likes: true, comments: true }
          }
        }
      }),
      this.prisma.short.count()
    ]);

    return {
      data: shorts,
      meta: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit)
      }
    };
  }

  async getShortById(id: string) {
    const short = await this.prisma.short.findUnique({
      where: { id },
      include: {
        author: {
          select: { id: true, name: true, username: true, avatar: true }
        },
        _count: {
          select: { likes: true, comments: true }
        }
      }
    });
    if (!short) throw new NotFoundException('Short not found');
    return short;
  }

  async createShort(authorId: string, videoUrl: string, caption?: string, thumbnailUrl?: string) {
    return this.prisma.short.create({
      data: {
        authorId,
        videoUrl,
        caption,
        thumbnailUrl,
      },
      include: {
        author: {
          select: { id: true, name: true, username: true, avatar: true }
        }
      }
    });
  }

  async toggleLike(shortId: string, userId: string) {
    const existingLike = await this.prisma.shortLike.findUnique({
      where: { shortId_userId: { shortId, userId } }
    });

    if (existingLike) {
      await this.prisma.shortLike.delete({ where: { id: existingLike.id } });
      await this.prisma.short.update({
        where: { id: shortId },
        data: { likeCount: { decrement: 1 } }
      });
      return { liked: false };
    } else {
      await this.prisma.shortLike.create({
        data: { shortId, userId }
      });
      const updatedShort = await this.prisma.short.update({
        where: { id: shortId },
        data: { likeCount: { increment: 1 } },
        include: { author: true }
      });

      if (updatedShort.authorId !== userId) {
        const liker = await this.prisma.user.findUnique({ where: { id: userId } });
        await this.notificationsService.createNotification(
          updatedShort.authorId,
          'LIKE',
          'Lượt thích Short mới',
          `${liker?.name || liker?.username} đã thích video ngắn của bạn.`,
          { shortId }
        );
      }

      return { liked: true };
    }
  }

  async getComments(shortId: string) {
    return this.prisma.shortComment.findMany({
      where: { shortId },
      orderBy: { createdAt: 'asc' },
      include: {
        author: { select: { id: true, name: true, username: true, avatar: true } }
      }
    });
  }

  async createComment(shortId: string, authorId: string, content: string, parentId?: string) {
    const comment = await this.prisma.shortComment.create({
      data: { content, shortId, authorId, parentId },
      include: { author: { select: { id: true, name: true, username: true, avatar: true } } }
    });

    const short = await this.prisma.short.update({
      where: { id: shortId },
      data: { commentCount: { increment: 1 } }
    });

    if (short.authorId !== authorId) {
      await this.notificationsService.createNotification(
        short.authorId,
        'COMMENT',
        'Bình luận Short mới',
        `${comment.author.name || comment.author.username} đã bình luận: "${content}"`,
        { shortId, commentId: comment.id }
      );
    }

    return comment;
  }
}
