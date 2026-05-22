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
exports.ReactionsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let ReactionsService = class ReactionsService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async toggleDiscussionReaction(discussionId, userId, emoji) {
        const discussion = await this.prisma.discussion.findUnique({ where: { id: discussionId } });
        if (!discussion)
            throw new common_1.NotFoundException('Discussion not found');
        const existing = await this.prisma.reaction.findUnique({
            where: { userId_discussionId_emoji: { userId, discussionId, emoji } },
        });
        if (existing) {
            await this.prisma.reaction.delete({ where: { id: existing.id } });
            await this.prisma.discussion.update({
                where: { id: discussionId },
                data: { reactionCount: { decrement: 1 } },
            });
            return { reacted: false, emoji };
        }
        else {
            await this.prisma.reaction.create({
                data: { userId, discussionId, emoji },
            });
            await this.prisma.discussion.update({
                where: { id: discussionId },
                data: { reactionCount: { increment: 1 } },
            });
            return { reacted: true, emoji };
        }
    }
    async toggleReplyReaction(replyId, userId, emoji) {
        const reply = await this.prisma.reply.findUnique({ where: { id: replyId } });
        if (!reply)
            throw new common_1.NotFoundException('Reply not found');
        const existing = await this.prisma.reaction.findUnique({
            where: { userId_replyId_emoji: { userId, replyId, emoji } },
        });
        if (existing) {
            await this.prisma.reaction.delete({ where: { id: existing.id } });
            return { reacted: false, emoji };
        }
        else {
            await this.prisma.reaction.create({
                data: { userId, replyId, emoji },
            });
            return { reacted: true, emoji };
        }
    }
    async getDiscussionReactions(discussionId, userId) {
        const reactions = await this.prisma.reaction.findMany({
            where: { discussionId },
            include: {
                user: { select: { id: true, name: true, username: true, avatar: true } },
            },
        });
        const summary = this.groupReactions(reactions, userId);
        return summary;
    }
    async getReplyReactions(replyId, userId) {
        const reactions = await this.prisma.reaction.findMany({
            where: { replyId },
            include: {
                user: { select: { id: true, name: true, username: true, avatar: true } },
            },
        });
        const summary = this.groupReactions(reactions, userId);
        return summary;
    }
    groupReactions(reactions, currentUserId) {
        const emojiMap = new Map();
        for (const reaction of reactions) {
            if (!emojiMap.has(reaction.emoji)) {
                emojiMap.set(reaction.emoji, {
                    emoji: reaction.emoji,
                    count: 0,
                    reacted: false,
                    users: [],
                });
            }
            const entry = emojiMap.get(reaction.emoji);
            entry.count++;
            entry.users.push(reaction.user);
            if (currentUserId && reaction.userId === currentUserId) {
                entry.reacted = true;
            }
        }
        return Array.from(emojiMap.values());
    }
};
exports.ReactionsService = ReactionsService;
exports.ReactionsService = ReactionsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], ReactionsService);
//# sourceMappingURL=reactions.service.js.map