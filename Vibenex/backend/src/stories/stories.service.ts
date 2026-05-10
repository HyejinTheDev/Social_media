import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateStoryDto } from './dto/create-story.dto';
import { MediaType } from '@prisma/client';

@Injectable()
export class StoriesService {
  constructor(private prisma: PrismaService) {}

  private readonly authorSelect = {
    id: true,
    name: true,
    username: true,
    avatar: true,
    isVerified: true,
  };

  async create(
    userId: string,
    dto: CreateStoryDto,
    fileUrl: string,
    mediaType: MediaType,
  ) {
    const expiresAt = new Date();
    expiresAt.setHours(expiresAt.getHours() + 24);

    return this.prisma.story.create({
      data: {
        authorId: userId,
        mediaUrl: fileUrl,
        mediaType,
        caption: dto.caption || null,
        expiresAt,
      },
      include: {
        author: { select: this.authorSelect },
      },
    });
  }

  async getActiveStories(currentUserId: string) {
    const now = new Date();

    const stories = await this.prisma.story.findMany({
      where: { expiresAt: { gt: now } },
      orderBy: { createdAt: 'desc' },
      include: {
        author: { select: this.authorSelect },
        views: {
          where: { viewerId: currentUserId },
          select: { id: true },
        },
      },
    });

    // Group by author
    const groupMap = new Map<string, {
      author: any;
      stories: any[];
      hasUnviewed: boolean;
      latestCreatedAt: Date;
    }>();

    for (const story of stories) {
      const authorId = story.authorId;
      const isViewed = story.views.length > 0;

      // Remove views from response payload
      const { views, ...storyData } = story;

      if (!groupMap.has(authorId)) {
        groupMap.set(authorId, {
          author: story.author,
          stories: [],
          hasUnviewed: false,
          latestCreatedAt: story.createdAt,
        });
      }

      const group = groupMap.get(authorId)!;
      group.stories.push({ ...storyData, isViewed });
      if (!isViewed) group.hasUnviewed = true;
    }

    // Sort: current user first, then unviewed groups, then viewed
    const groups = Array.from(groupMap.values());
    groups.sort((a, b) => {
      const aIsMe = a.author.id === currentUserId ? -1 : 0;
      const bIsMe = b.author.id === currentUserId ? -1 : 0;
      if (aIsMe !== bIsMe) return aIsMe - bIsMe;

      if (a.hasUnviewed !== b.hasUnviewed) return a.hasUnviewed ? -1 : 1;
      return b.latestCreatedAt.getTime() - a.latestCreatedAt.getTime();
    });

    return { groups };
  }

  async viewStory(userId: string, storyId: string) {
    const story = await this.prisma.story.findUnique({
      where: { id: storyId },
    });
    if (!story) throw new NotFoundException('Story không tồn tại');

    // Don't count self-views
    if (story.authorId === userId) {
      return { success: true, selfView: true };
    }

    // Upsert view + increment count atomically
    const existingView = await this.prisma.storyView.findUnique({
      where: { storyId_viewerId: { storyId, viewerId: userId } },
    });

    if (!existingView) {
      await this.prisma.$transaction([
        this.prisma.storyView.create({
          data: { storyId, viewerId: userId },
        }),
        this.prisma.story.update({
          where: { id: storyId },
          data: { viewCount: { increment: 1 } },
        }),
      ]);
    }

    return { success: true };
  }

  async deleteStory(userId: string, storyId: string) {
    const story = await this.prisma.story.findUnique({
      where: { id: storyId },
    });
    if (!story) throw new NotFoundException('Story không tồn tại');
    if (story.authorId !== userId) {
      throw new ForbiddenException('Bạn không có quyền xóa story này');
    }

    await this.prisma.story.delete({ where: { id: storyId } });
    return { success: true, message: 'Đã xóa story' };
  }

  async getMyStories(userId: string) {
    const now = new Date();

    const stories = await this.prisma.story.findMany({
      where: { authorId: userId, expiresAt: { gt: now } },
      orderBy: { createdAt: 'desc' },
      include: {
        views: {
          include: {
            viewer: { select: this.authorSelect },
          },
          orderBy: { viewedAt: 'desc' },
        },
      },
    });

    return { stories };
  }
}
