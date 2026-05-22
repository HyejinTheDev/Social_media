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
exports.StoriesService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let StoriesService = class StoriesService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async createStory(userId, imageUrl, videoUrl, caption) {
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
    async getFeed(userId) {
        const now = new Date();
        const friends = await this.prisma.friendRequest.findMany({
            where: {
                status: 'ACCEPTED',
                OR: [{ senderId: userId }, { receiverId: userId }],
            },
        });
        const friendIds = friends.map((f) => (f.senderId === userId ? f.receiverId : f.senderId));
        const allIds = [userId, ...friendIds];
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
        return stories.map((story) => ({
            ...story,
            isViewed: story.views.length > 0,
            views: undefined,
        }));
    }
    async viewStory(storyId, viewerId) {
        const story = await this.prisma.story.findUnique({ where: { id: storyId } });
        if (!story)
            throw new common_1.NotFoundException('Story không tồn tại');
        if (story.authorId === viewerId)
            return { success: true };
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
        await this.prisma.story.update({
            where: { id: storyId },
            data: { viewCount: { increment: 1 } },
        });
        return { success: true };
    }
    async deleteStory(storyId, userId) {
        const story = await this.prisma.story.findUnique({ where: { id: storyId } });
        if (!story)
            throw new common_1.NotFoundException('Story không tồn tại');
        if (story.authorId !== userId)
            throw new common_1.ForbiddenException('Bạn không có quyền xoá story này');
        await this.prisma.story.delete({ where: { id: storyId } });
        return { message: 'Đã xoá story' };
    }
    async getMyStories(userId) {
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
};
exports.StoriesService = StoriesService;
exports.StoriesService = StoriesService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], StoriesService);
//# sourceMappingURL=stories.service.js.map