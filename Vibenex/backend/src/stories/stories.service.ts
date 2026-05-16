import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class StoriesService {
  constructor(private prisma: PrismaService) {}

  async createStory(userId: string, imageUrl?: string, videoUrl?: string) {
    // Expires in 24 hours
    const expiresAt = new Date();
    expiresAt.setHours(expiresAt.getHours() + 24);

    return this.prisma.story.create({
      data: {
        authorId: userId,
        imageUrl,
        videoUrl,
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
      },
      orderBy: { createdAt: 'desc' },
    });

    return stories;
  }
}
