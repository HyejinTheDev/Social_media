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
exports.PostsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const notifications_service_1 = require("../notifications/notifications.service");
const client_1 = require("@prisma/client");
const client_2 = require("@prisma/client");
let PostsService = class PostsService {
    prisma;
    notificationsService;
    constructor(prisma, notificationsService) {
        this.prisma = prisma;
        this.notificationsService = notificationsService;
    }
    async create(userId, dto, fileUrls) {
        let mediaType = client_2.MediaType.TEXT;
        if (fileUrls.video)
            mediaType = client_2.MediaType.VIDEO;
        else if (fileUrls.images && fileUrls.images.length > 0)
            mediaType = client_2.MediaType.IMAGE;
        return this.prisma.post.create({
            data: {
                content: dto.content || "",
                authorId: userId,
                mediaType,
                imageUrls: fileUrls.images || [],
                videoUrl: fileUrls.video || null,
                videoThumbnailUrl: fileUrls.thumbnail || null,
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
    async getFeed(page = 1, limit = 10) {
        const skip = (page - 1) * limit;
        const [posts, total] = await Promise.all([
            this.prisma.post.findMany({
                skip,
                take: limit,
                orderBy: { createdAt: 'desc' },
                include: {
                    author: {
                        select: { id: true, name: true, username: true, avatar: true, isVerified: true },
                    },
                },
            }),
            this.prisma.post.count(),
        ]);
        return {
            posts,
            total,
            page,
            totalPages: Math.ceil(total / limit),
        };
    }
    async getPostById(id) {
        const post = await this.prisma.post.findUnique({
            where: { id },
            include: {
                author: {
                    select: { id: true, name: true, username: true, avatar: true, isVerified: true },
                },
            },
        });
        if (!post)
            throw new common_1.NotFoundException('Bài viết không tồn tại');
        return post;
    }
    async getUserPosts(userId, page = 1, limit = 10) {
        const skip = (page - 1) * limit;
        const [posts, total] = await Promise.all([
            this.prisma.post.findMany({
                where: { authorId: userId },
                skip,
                take: limit,
                orderBy: { createdAt: 'desc' },
                include: {
                    author: {
                        select: { id: true, name: true, username: true, avatar: true, isVerified: true },
                    },
                },
            }),
            this.prisma.post.count({ where: { authorId: userId } }),
        ]);
        return {
            posts,
            total,
            page,
            totalPages: Math.ceil(total / limit),
        };
    }
    async remove(userId, postId) {
        const post = await this.prisma.post.findUnique({
            where: { id: postId },
        });
        if (!post)
            throw new common_1.NotFoundException('Bài viết không tồn tại');
        if (post.authorId !== userId)
            throw new common_1.ForbiddenException('Bạn không có quyền xóa bài viết này');
        await this.prisma.post.delete({ where: { id: postId } });
        return { success: true, message: 'Đã xóa bài viết' };
    }
    async toggleLike(userId, postId) {
        const post = await this.prisma.post.findUnique({ where: { id: postId } });
        if (!post)
            throw new common_1.NotFoundException('Bài viết không tồn tại');
        const existingLike = await this.prisma.like.findUnique({
            where: {
                postId_userId: { postId, userId }
            }
        });
        if (existingLike) {
            await this.prisma.$transaction([
                this.prisma.like.delete({
                    where: { postId_userId: { postId, userId } }
                }),
                this.prisma.post.update({
                    where: { id: postId },
                    data: { likesCount: { decrement: 1 } }
                })
            ]);
            return { liked: false };
        }
        else {
            await this.prisma.$transaction([
                this.prisma.like.create({
                    data: { postId, userId }
                }),
                this.prisma.post.update({
                    where: { id: postId },
                    data: { likesCount: { increment: 1 } }
                })
            ]);
            if (post.authorId !== userId) {
                const liker = await this.prisma.user.findUnique({ where: { id: userId }, select: { name: true } });
                await this.notificationsService.createNotification(post.authorId, client_1.NotificationType.LIKE, 'Có người thích bài viết của bạn', `${liker?.name} đã thích bài viết của bạn.`, { postId });
            }
            return { liked: true };
        }
    }
    async getLikeStatus(userId, postId) {
        const like = await this.prisma.like.findUnique({
            where: { postId_userId: { postId, userId } }
        });
        return { liked: !!like };
    }
};
exports.PostsService = PostsService;
exports.PostsService = PostsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService,
        notifications_service_1.NotificationsService])
], PostsService);
//# sourceMappingURL=posts.service.js.map