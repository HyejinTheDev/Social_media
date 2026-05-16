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
exports.ShortsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const notifications_service_1 = require("../notifications/notifications.service");
let ShortsService = class ShortsService {
    prisma;
    notificationsService;
    constructor(prisma, notificationsService) {
        this.prisma = prisma;
        this.notificationsService = notificationsService;
    }
    async getFeed(page, limit) {
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
    async getShortById(id) {
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
        if (!short)
            throw new common_1.NotFoundException('Short not found');
        return short;
    }
    async createShort(authorId, videoUrl, caption, thumbnailUrl) {
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
    async toggleLike(shortId, userId) {
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
        }
        else {
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
                await this.notificationsService.createNotification(updatedShort.authorId, 'LIKE', 'Lượt thích Short mới', `${liker?.name || liker?.username} đã thích video ngắn của bạn.`, { shortId });
            }
            return { liked: true };
        }
    }
    async getComments(shortId) {
        return this.prisma.shortComment.findMany({
            where: { shortId },
            orderBy: { createdAt: 'asc' },
            include: {
                author: { select: { id: true, name: true, username: true, avatar: true } }
            }
        });
    }
    async createComment(shortId, authorId, content, parentId) {
        const comment = await this.prisma.shortComment.create({
            data: { content, shortId, authorId, parentId },
            include: { author: { select: { id: true, name: true, username: true, avatar: true } } }
        });
        const short = await this.prisma.short.update({
            where: { id: shortId },
            data: { commentCount: { increment: 1 } }
        });
        if (short.authorId !== authorId) {
            await this.notificationsService.createNotification(short.authorId, 'COMMENT', 'Bình luận Short mới', `${comment.author.name || comment.author.username} đã bình luận: "${content}"`, { shortId, commentId: comment.id });
        }
        return comment;
    }
};
exports.ShortsService = ShortsService;
exports.ShortsService = ShortsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService,
        notifications_service_1.NotificationsService])
], ShortsService);
//# sourceMappingURL=shorts.service.js.map