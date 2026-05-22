import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class StoriesService {
  constructor(private prisma: PrismaService) {}

  async createStory(userId: string, imageUrl?: string, videoUrl?: string, caption?: string) {
    // Expires in 24 hours
    const expiresAt = new Date();
    expiresAt.setHours(expiresAt.getHours() + 24);

    return this.prisma.story.create({
      data: {
        authorId: userId,
        imageUrl,
        videoUrl,
        caption,
        expiresAt,
      },
      include: {
        author: {
          select: {
            id: true,
            name: true,
            username: true,
            avatar: true,
            isVerified: true,
          },
        },
      },
    });
  }

  async getFeed(userId: string) {
    const now = new Date();

    // Lấy danh sách bạn bè đã ACCEPTED
    const friends = await this.prisma.friendRequest.findMany({
      where: {
        status: 'ACCEPTED',
        OR: [{ senderId: userId }, { receiverId: userId }],
      },
    });

    const friendIds = friends.map((f) => (f.senderId === userId ? f.receiverId : f.senderId));
    const allIds = [userId, ...friendIds];

    // Lấy tất cả story chưa hết hạn của mình và bạn bè
    const stories = await this.prisma.story.findMany({
      where: {
        authorId: { in: allIds },
        expiresAt: { gt: now },
      },
      include: {
        author: {
          select: {
            id: true,
            name: true,
            username: true,
            avatar: true,
            isVerified: true,
          },
        },
        views: {
          where: { viewerId: userId },
          select: { id: true },
        },
      },
      orderBy: { createdAt: 'desc' },
    });

    // Add isViewed flag
    return stories.map((story) => ({
      ...story,
      isViewed: story.views.length > 0,
      views: undefined, // Don't expose raw views array
    }));
  }

  async viewStory(storyId: string, viewerId: string) {
    const story = await this.prisma.story.findUnique({ where: { id: storyId } });
    if (!story) throw new NotFoundException('Story không tồn tại');

    // Don't count self-views
    if (story.authorId === viewerId) return { success: true };

    // Upsert view (idempotent)
    await this.prisma.storyView.upsert({
      where: {
        storyId_viewerId: { storyId, viewerId },
      },
      create: {
        storyId,
        viewerId,
      },
      update: {},
    });

    // Increment view count
    await this.prisma.story.update({
      where: { id: storyId },
      data: { viewCount: { increment: 1 } },
    });

    return { success: true };
  }

  async deleteStory(storyId: string, userId: string) {
    const story = await this.prisma.story.findUnique({ where: { id: storyId } });
    if (!story) throw new NotFoundException('Story không tồn tại');
    if (story.authorId !== userId) throw new ForbiddenException('Bạn không có quyền xoá story này');

    await this.prisma.story.delete({ where: { id: storyId } });
    return { message: 'Đã xoá story' };
  }

  async getMyStories(userId: string) {
    const now = new Date();
    return this.prisma.story.findMany({
      where: {
        authorId: userId,
        expiresAt: { gt: now },
      },
      include: {
        views: {
          include: {
            viewer: {
              select: { id: true, name: true, username: true, avatar: true },
            },
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });
  }
}
