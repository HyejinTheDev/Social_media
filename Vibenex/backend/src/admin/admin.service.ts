import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class AdminService {
  constructor(private prisma: PrismaService) {}

  // ── Dashboard Stats ──
  async getStats() {
    const [
      totalUsers, totalPosts, totalShorts, totalCommunities,
      totalMessages, totalStories,
    ] = await Promise.all([
      this.prisma.user.count(),
      this.prisma.post.count(),
      this.prisma.short.count(),
      this.prisma.community.count(),
      this.prisma.message.count(),
      this.prisma.story.count(),
    ]);

    // Users registered in last 7 days
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
    const newUsers = await this.prisma.user.count({
      where: { createdAt: { gte: sevenDaysAgo } },
    });

    // Daily registration stats (last 7 days)
    const dailyUsers = await this.prisma.$queryRaw`
      SELECT DATE(\"createdAt\") as date, COUNT(*)::int as count
      FROM "User"
      WHERE "createdAt" >= ${sevenDaysAgo}
      GROUP BY DATE("createdAt")
      ORDER BY date ASC
    ` as { date: Date; count: number }[];

    const dailyPosts = await this.prisma.$queryRaw`
      SELECT DATE(\"createdAt\") as date, COUNT(*)::int as count
      FROM "Post"
      WHERE "createdAt" >= ${sevenDaysAgo}
      GROUP BY DATE("createdAt")
      ORDER BY date ASC
    ` as { date: Date; count: number }[];

    return {
      totalUsers,
      totalPosts,
      totalShorts,
      totalCommunities,
      totalMessages,
      totalStories,
      newUsers,
      dailyUsers,
      dailyPosts,
    };
  }

  // ── User Management ──
  async getUsers(page = 1, limit = 20, search?: string) {
    const skip = (page - 1) * limit;
    const where = search
      ? {
          OR: [
            { name: { contains: search, mode: 'insensitive' as const } },
            { email: { contains: search, mode: 'insensitive' as const } },
            { username: { contains: search, mode: 'insensitive' as const } },
          ],
        }
      : {};

    const [users, total] = await Promise.all([
      this.prisma.user.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        select: {
          id: true,
          name: true,
          username: true,
          email: true,
          avatar: true,
          reputation: true,
          isVerified: true,
          role: true,
          createdAt: true,
          _count: {
            select: { posts: true, shorts: true },
          },
        },
      }),
      this.prisma.user.count({ where }),
    ]);

    return { users, total, page, totalPages: Math.ceil(total / limit) };
  }

  async deleteUser(userId: string) {
    // Cascade delete all related data
    const userDiscussions = await this.prisma.discussion.findMany({ where: { authorId: userId }, select: { id: true } });
    const discussionIds = userDiscussions.map(d => d.id);
    const userConversations = await this.prisma.conversation.findMany({
      where: { OR: [{ participant1Id: userId }, { participant2Id: userId }] },
      select: { id: true },
    });
    const conversationIds = userConversations.map(c => c.id);

    await this.prisma.$transaction([
      this.prisma.shortComment.deleteMany({ where: { authorId: userId } }),
      this.prisma.shortLike.deleteMany({ where: { userId } }),
      this.prisma.comment.deleteMany({ where: { authorId: userId } }),
      this.prisma.postLike.deleteMany({ where: { userId } }),
      this.prisma.reaction.deleteMany({ where: { userId } }),
      this.prisma.reply.deleteMany({ where: { discussionId: { in: discussionIds } } }),
      this.prisma.reply.deleteMany({ where: { authorId: userId } }),
      this.prisma.message.deleteMany({ where: { conversationId: { in: conversationIds } } }),
      this.prisma.conversation.deleteMany({ where: { id: { in: conversationIds } } }),
      this.prisma.communityMember.deleteMany({ where: { userId } }),
      this.prisma.notification.deleteMany({ where: { userId } }),
      this.prisma.friendRequest.deleteMany({ where: { OR: [{ senderId: userId }, { receiverId: userId }] } }),
      this.prisma.story.deleteMany({ where: { authorId: userId } }),
      this.prisma.short.deleteMany({ where: { authorId: userId } }),
      this.prisma.post.deleteMany({ where: { authorId: userId } }),
      this.prisma.discussion.deleteMany({ where: { authorId: userId } }),
      this.prisma.user.delete({ where: { id: userId } }),
    ]);

    return { message: 'Đã xóa tài khoản người dùng' };
  }

  async toggleVerify(userId: string) {
    const user = await this.prisma.user.findUnique({ where: { id: userId }, select: { isVerified: true } });
    const updated = await this.prisma.user.update({
      where: { id: userId },
      data: { isVerified: !user?.isVerified },
    });
    return { isVerified: updated.isVerified };
  }

  // ── Post Management ──
  async getPosts(page = 1, limit = 20, search?: string) {
    const skip = (page - 1) * limit;
    const where = search ? { content: { contains: search, mode: 'insensitive' as const } } : {};

    const [posts, total] = await Promise.all([
      this.prisma.post.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          author: { select: { id: true, name: true, username: true, avatar: true } },
        },
      }),
      this.prisma.post.count({ where }),
    ]);

    return { posts, total, page, totalPages: Math.ceil(total / limit) };
  }

  async deletePost(postId: string) {
    await this.prisma.$transaction([
      this.prisma.comment.deleteMany({ where: { postId } }),
      this.prisma.postLike.deleteMany({ where: { postId } }),
      this.prisma.post.delete({ where: { id: postId } }),
    ]);
    return { message: 'Đã xóa bài viết' };
  }

  // ── Shorts Management ──
  async getShorts(page = 1, limit = 20) {
    const skip = (page - 1) * limit;
    const [shorts, total] = await Promise.all([
      this.prisma.short.findMany({
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          author: { select: { id: true, name: true, username: true, avatar: true } },
        },
      }),
      this.prisma.short.count(),
    ]);
    return { shorts, total, page, totalPages: Math.ceil(total / limit) };
  }

  async deleteShort(shortId: string) {
    await this.prisma.$transaction([
      this.prisma.shortComment.deleteMany({ where: { shortId } }),
      this.prisma.shortLike.deleteMany({ where: { shortId } }),
      this.prisma.short.delete({ where: { id: shortId } }),
    ]);
    return { message: 'Đã xóa video ngắn' };
  }

  // ── Community Management ──
  async getCommunities(page = 1, limit = 20, search?: string) {
    const skip = (page - 1) * limit;
    const where = search ? { name: { contains: search, mode: 'insensitive' as const } } : {};

    const [communities, total] = await Promise.all([
      this.prisma.community.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          _count: { select: { members: true, channels: true } },
        },
      }),
      this.prisma.community.count({ where }),
    ]);

    return { communities, total, page, totalPages: Math.ceil(total / limit) };
  }

  async deleteCommunity(communityId: string) {
    // Channels and their related data will cascade delete
    await this.prisma.community.delete({ where: { id: communityId } });
    return { message: 'Đã xóa cộng đồng' };
  }
}
