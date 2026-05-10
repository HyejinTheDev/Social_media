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
    authorSelect = {
        id: true,
        name: true,
        username: true,
        avatar: true,
        isVerified: true,
    };
    async create(userId, dto, fileUrl, mediaType) {
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
    async getActiveStories(currentUserId) {
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
        const groupMap = new Map();
        for (const story of stories) {
            const authorId = story.authorId;
            const isViewed = story.views.length > 0;
            const { views, ...storyData } = story;
            if (!groupMap.has(authorId)) {
                groupMap.set(authorId, {
                    author: story.author,
                    stories: [],
                    hasUnviewed: false,
                    latestCreatedAt: story.createdAt,
                });
            }
            const group = groupMap.get(authorId);
            group.stories.push({ ...storyData, isViewed });
            if (!isViewed)
                group.hasUnviewed = true;
        }
        const groups = Array.from(groupMap.values());
        groups.sort((a, b) => {
            const aIsMe = a.author.id === currentUserId ? -1 : 0;
            const bIsMe = b.author.id === currentUserId ? -1 : 0;
            if (aIsMe !== bIsMe)
                return aIsMe - bIsMe;
            if (a.hasUnviewed !== b.hasUnviewed)
                return a.hasUnviewed ? -1 : 1;
            return b.latestCreatedAt.getTime() - a.latestCreatedAt.getTime();
        });
        return { groups };
    }
    async viewStory(userId, storyId) {
        const story = await this.prisma.story.findUnique({
            where: { id: storyId },
        });
        if (!story)
            throw new common_1.NotFoundException('Story không tồn tại');
        if (story.authorId === userId) {
            return { success: true, selfView: true };
        }
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
    async deleteStory(userId, storyId) {
        const story = await this.prisma.story.findUnique({
            where: { id: storyId },
        });
        if (!story)
            throw new common_1.NotFoundException('Story không tồn tại');
        if (story.authorId !== userId) {
            throw new common_1.ForbiddenException('Bạn không có quyền xóa story này');
        }
        await this.prisma.story.delete({ where: { id: storyId } });
        return { success: true, message: 'Đã xóa story' };
    }
    async getMyStories(userId) {
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
};
exports.StoriesService = StoriesService;
exports.StoriesService = StoriesService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], StoriesService);
//# sourceMappingURL=stories.service.js.map