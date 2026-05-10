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
exports.FollowService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const notifications_service_1 = require("../notifications/notifications.service");
const client_1 = require("@prisma/client");
let FollowService = class FollowService {
    prisma;
    notificationsService;
    constructor(prisma, notificationsService) {
        this.prisma = prisma;
        this.notificationsService = notificationsService;
    }
    userSelect = {
        id: true,
        name: true,
        username: true,
        avatar: true,
        bio: true,
        isVerified: true,
        followersCount: true,
        followingCount: true,
    };
    async follow(followerId, followingId) {
        if (followerId === followingId) {
            throw new common_1.BadRequestException('Không thể tự theo dõi chính mình');
        }
        const target = await this.prisma.user.findUnique({ where: { id: followingId } });
        if (!target)
            throw new common_1.NotFoundException('Người dùng không tồn tại');
        const existing = await this.prisma.follow.findUnique({
            where: { followerId_followingId: { followerId, followingId } },
        });
        if (existing) {
            return { following: true, message: 'Đã theo dõi từ trước' };
        }
        await this.prisma.$transaction([
            this.prisma.follow.create({
                data: { followerId, followingId },
            }),
            this.prisma.user.update({
                where: { id: followerId },
                data: { followingCount: { increment: 1 } },
            }),
            this.prisma.user.update({
                where: { id: followingId },
                data: { followersCount: { increment: 1 } },
            }),
        ]);
        const follower = await this.prisma.user.findUnique({ where: { id: followerId }, select: { name: true } });
        await this.notificationsService.createNotification(followingId, client_1.NotificationType.FOLLOW, 'Người theo dõi mới', `${follower?.name} đã bắt đầu theo dõi bạn.`, { followerId });
        return { following: true };
    }
    async unfollow(followerId, followingId) {
        if (followerId === followingId) {
            throw new common_1.BadRequestException('Không thể bỏ theo dõi chính mình');
        }
        const existing = await this.prisma.follow.findUnique({
            where: { followerId_followingId: { followerId, followingId } },
        });
        if (!existing) {
            return { following: false, message: 'Chưa theo dõi người này' };
        }
        await this.prisma.$transaction([
            this.prisma.follow.delete({
                where: { followerId_followingId: { followerId, followingId } },
            }),
            this.prisma.user.update({
                where: { id: followerId },
                data: { followingCount: { decrement: 1 } },
            }),
            this.prisma.user.update({
                where: { id: followingId },
                data: { followersCount: { decrement: 1 } },
            }),
        ]);
        return { following: false };
    }
    async getFollowStatus(followerId, followingId) {
        const follow = await this.prisma.follow.findUnique({
            where: { followerId_followingId: { followerId, followingId } },
        });
        return { following: !!follow };
    }
    async getFollowers(userId, page = 1, limit = 20) {
        const skip = (page - 1) * limit;
        const [follows, total] = await Promise.all([
            this.prisma.follow.findMany({
                where: { followingId: userId },
                skip,
                take: limit,
                orderBy: { createdAt: 'desc' },
                include: {
                    follower: { select: this.userSelect },
                },
            }),
            this.prisma.follow.count({ where: { followingId: userId } }),
        ]);
        return {
            users: follows.map(f => f.follower),
            total,
            page,
            totalPages: Math.ceil(total / limit),
        };
    }
    async getFollowing(userId, page = 1, limit = 20) {
        const skip = (page - 1) * limit;
        const [follows, total] = await Promise.all([
            this.prisma.follow.findMany({
                where: { followerId: userId },
                skip,
                take: limit,
                orderBy: { createdAt: 'desc' },
                include: {
                    following: { select: this.userSelect },
                },
            }),
            this.prisma.follow.count({ where: { followerId: userId } }),
        ]);
        return {
            users: follows.map(f => f.following),
            total,
            page,
            totalPages: Math.ceil(total / limit),
        };
    }
};
exports.FollowService = FollowService;
exports.FollowService = FollowService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService,
        notifications_service_1.NotificationsService])
], FollowService);
//# sourceMappingURL=follow.service.js.map