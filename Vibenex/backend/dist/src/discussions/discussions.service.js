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
exports.DiscussionsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let DiscussionsService = class DiscussionsService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async findByChannel(channelId, page, limit) {
        const where = { channelId };
        const [discussions, total] = await Promise.all([
            this.prisma.discussion.findMany({
                where,
                skip: (page - 1) * limit,
                take: limit,
                orderBy: { createdAt: 'desc' },
                include: {
                    author: {
                        select: { id: true, name: true, username: true, avatar: true },
                    },
                },
            }),
            this.prisma.discussion.count({ where }),
        ]);
        return { discussions, total };
    }
    async findById(id) {
        const discussion = await this.prisma.discussion.findUnique({
            where: { id },
            include: {
                author: {
                    select: { id: true, name: true, username: true, avatar: true },
                },
            },
        });
        if (!discussion)
            throw new common_1.NotFoundException('Discussion not found');
        return discussion;
    }
    async create(channelId, authorId, data) {
        const channel = await this.prisma.channel.findUnique({ where: { id: channelId } });
        if (!channel)
            throw new common_1.NotFoundException('Channel not found');
        return this.prisma.discussion.create({
            data: {
                channelId,
                authorId,
                content: data.content,
                imageUrls: data.imageUrls || [],
                linkUrl: data.linkUrl,
            },
            include: {
                author: {
                    select: { id: true, name: true, username: true, avatar: true },
                },
            },
        });
    }
    async getReplies(discussionId) {
        const discussion = await this.prisma.discussion.findUnique({ where: { id: discussionId } });
        if (!discussion)
            throw new common_1.NotFoundException('Discussion not found');
        return this.prisma.reply.findMany({
            where: { discussionId },
            orderBy: { createdAt: 'asc' },
            include: {
                author: {
                    select: { id: true, name: true, username: true, avatar: true },
                },
            },
        });
    }
    async createReply(discussionId, authorId, data) {
        const discussion = await this.prisma.discussion.findUnique({ where: { id: discussionId } });
        if (!discussion)
            throw new common_1.NotFoundException('Discussion not found');
        const reply = await this.prisma.reply.create({
            data: {
                discussionId,
                authorId,
                content: data.content,
                parentId: data.parentId,
            },
            include: {
                author: {
                    select: { id: true, name: true, username: true, avatar: true },
                },
            },
        });
        await this.prisma.discussion.update({
            where: { id: discussionId },
            data: { replyCount: { increment: 1 } },
        });
        return reply;
    }
};
exports.DiscussionsService = DiscussionsService;
exports.DiscussionsService = DiscussionsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], DiscussionsService);
//# sourceMappingURL=discussions.service.js.map