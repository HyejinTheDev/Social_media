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
exports.CommentsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const notifications_service_1 = require("../notifications/notifications.service");
const client_1 = require("@prisma/client");
let CommentsService = class CommentsService {
    prisma;
    notificationsService;
    constructor(prisma, notificationsService) {
        this.prisma = prisma;
        this.notificationsService = notificationsService;
    }
    async create(userId, postId, dto) {
        const post = await this.prisma.post.findUnique({ where: { id: postId } });
        if (!post)
            throw new common_1.NotFoundException('Bài viết không tồn tại');
        const [comment] = await this.prisma.$transaction([
            this.prisma.comment.create({
                data: {
                    content: dto.content,
                    postId,
                    authorId: userId,
                },
                include: {
                    author: { select: { id: true, name: true, username: true, avatar: true } }
                }
            }),
            this.prisma.post.update({
                where: { id: postId },
                data: { commentsCount: { increment: 1 } }
            })
        ]);
        if (post.authorId !== userId) {
            const commenter = await this.prisma.user.findUnique({ where: { id: userId }, select: { name: true } });
            let snippet = dto.content;
            if (snippet.length > 30)
                snippet = snippet.substring(0, 30) + '...';
            await this.notificationsService.createNotification(post.authorId, client_1.NotificationType.COMMENT, 'Có bình luận mới', `${commenter?.name} đã bình luận: "${snippet}"`, { postId, commentId: comment.id });
        }
        return comment;
    }
    async getComments(postId, page = 1, limit = 20) {
        const post = await this.prisma.post.findUnique({ where: { id: postId } });
        if (!post)
            throw new common_1.NotFoundException('Bài viết không tồn tại');
        const skip = (page - 1) * limit;
        const [comments, total] = await Promise.all([
            this.prisma.comment.findMany({
                where: { postId },
                skip,
                take: limit,
                orderBy: { createdAt: 'desc' },
                include: {
                    author: { select: { id: true, name: true, username: true, avatar: true } }
                }
            }),
            this.prisma.comment.count({ where: { postId } })
        ]);
        return {
            comments,
            total,
            page,
            totalPages: Math.ceil(total / limit),
        };
    }
    async remove(userId, id) {
        const comment = await this.prisma.comment.findUnique({
            where: { id },
            include: { post: true }
        });
        if (!comment)
            throw new common_1.NotFoundException('Bình luận không tồn tại');
        if (comment.authorId !== userId) {
            throw new common_1.ForbiddenException('Bạn không có quyền xóa bình luận này');
        }
        await this.prisma.$transaction([
            this.prisma.comment.delete({ where: { id } }),
            this.prisma.post.update({
                where: { id: comment.postId },
                data: { commentsCount: { decrement: 1 } }
            })
        ]);
        return { success: true, message: 'Đã xóa bình luận' };
    }
};
exports.CommentsService = CommentsService;
exports.CommentsService = CommentsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService,
        notifications_service_1.NotificationsService])
], CommentsService);
//# sourceMappingURL=comments.service.js.map