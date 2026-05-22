"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AdminService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let AdminService = class AdminService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async getStats() {
        const [totalUsers, totalPosts, totalShorts, totalCommunities, totalMessages, totalStories,] = await Promise.all([
            this.prisma.user.count(),
            this.prisma.post.count(),
            this.prisma.short.count(),
            this.prisma.community.count(),
            this.prisma.message.count(),
            this.prisma.story.count(),
        ]);
        const sevenDaysAgo = new Date();
        sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
        const newUsers = await this.prisma.user.count({
            where: { createdAt: { gte: sevenDaysAgo } },
        });
        const dailyUsers = await this.prisma.$queryRaw `
      SELECT DATE("createdAt") as date, COUNT(*)::int as count
      FROM "User"
      WHERE "createdAt" >= ${sevenDaysAgo}
      GROUP BY DATE("createdAt")
      ORDER BY date ASC
    `;
        const dailyPosts = await this.prisma.$queryRaw `
      SELECT DATE("createdAt") as date, COUNT(*)::int as count
      FROM "Post"
      WHERE "createdAt" >= ${sevenDaysAgo}
      GROUP BY DATE("createdAt")
      ORDER BY date ASC
    `;
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
    async getUsers(page = 1, limit = 20, search) {
        const skip = (page - 1) * limit;
        const where = search
            ? {
                OR: [
                    { name: { contains: search, mode: 'insensitive' } },
                    { email: { contains: search, mode: 'insensitive' } },
                    { username: { contains: search, mode: 'insensitive' } },
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
    async deleteUser(userId) {
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
    async toggleVerify(userId) {
        const user = await this.prisma.user.findUnique({ where: { id: userId }, select: { isVerified: true } });
        const updated = await this.prisma.user.update({
            where: { id: userId },
            data: { isVerified: !user?.isVerified },
        });
        return { isVerified: updated.isVerified };
    }
    async getPosts(page = 1, limit = 20, search) {
        const skip = (page - 1) * limit;
        const where = search ? { content: { contains: search, mode: 'insensitive' } } : {};
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
    async deletePost(postId) {
        await this.prisma.$transaction([
            this.prisma.comment.deleteMany({ where: { postId } }),
            this.prisma.postLike.deleteMany({ where: { postId } }),
            this.prisma.post.delete({ where: { id: postId } }),
        ]);
        return { message: 'Đã xóa bài viết' };
    }
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
    async deleteShort(shortId) {
        await this.prisma.$transaction([
            this.prisma.shortComment.deleteMany({ where: { shortId } }),
            this.prisma.shortLike.deleteMany({ where: { shortId } }),
            this.prisma.short.delete({ where: { id: shortId } }),
        ]);
        return { message: 'Đã xóa video ngắn' };
    }
    async getCommunities(page = 1, limit = 20, search) {
        const skip = (page - 1) * limit;
        const where = search ? { name: { contains: search, mode: 'insensitive' } } : {};
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
    async deleteCommunity(communityId) {
        await this.prisma.community.delete({ where: { id: communityId } });
        return { message: 'Đã xóa cộng đồng' };
    }
};
exports.AdminService = AdminService;
exports.AdminService = AdminService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], AdminService);
//# sourceMappingURL=admin.service.js.map