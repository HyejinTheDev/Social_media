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
exports.UsersService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let UsersService = class UsersService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async getProfile(userId) {
        const user = await this.prisma.user.findUnique({
            where: { id: userId },
        });
        if (!user)
            throw new common_1.NotFoundException('Không tìm thấy người dùng');
        return this.sanitize(user);
    }
    async getProfileById(userId, currentUserId) {
        const user = await this.prisma.user.findUnique({
            where: { id: userId },
        });
        if (!user)
            throw new common_1.NotFoundException('Không tìm thấy người dùng');
        return {
            ...this.sanitize(user),
            isOwnProfile: currentUserId === userId,
        };
    }
    async updateProfile(userId, dto) {
        if (dto.username) {
            const existing = await this.prisma.user.findUnique({
                where: { username: dto.username },
            });
            if (existing && existing.id !== userId) {
                throw new common_1.ConflictException('Tên người dùng đã tồn tại');
            }
        }
        const user = await this.prisma.user.update({
            where: { id: userId },
            data: {
                ...(dto.name && { name: dto.name }),
                ...(dto.username && { username: dto.username }),
                ...(dto.bio !== undefined && { bio: dto.bio }),
            },
        });
        return this.sanitize(user);
    }
    async updateAvatar(userId, filename) {
        const avatarUrl = `/uploads/avatars/${filename}`;
        const user = await this.prisma.user.update({
            where: { id: userId },
            data: { avatar: avatarUrl },
        });
        return this.sanitize(user);
    }
    async updateCover(userId, filename) {
        const coverUrl = `/uploads/covers/${filename}`;
        const user = await this.prisma.user.update({
            where: { id: userId },
            data: { coverPhoto: coverUrl },
        });
        return this.sanitize(user);
    }
    async searchUsers(query, currentUserId, page = 1, limit = 20) {
        const skip = (page - 1) * limit;
        const where = {
            id: { not: currentUserId },
            OR: [
                { name: { contains: query, mode: 'insensitive' } },
                { username: { contains: query, mode: 'insensitive' } },
            ],
        };
        const [users, total] = await Promise.all([
            this.prisma.user.findMany({
                where,
                skip,
                take: limit,
                orderBy: { reputation: 'desc' },
                select: {
                    id: true,
                    name: true,
                    username: true,
                    avatar: true,
                    bio: true,
                    isVerified: true,
                    reputation: true,
                },
            }),
            this.prisma.user.count({ where }),
        ]);
        return {
            users,
            total,
            page,
            totalPages: Math.ceil(total / limit),
        };
    }
    sanitize(user) {
        const { password, ...result } = user;
        return result;
    }
    async deleteAccount(userId) {
        const userDiscussions = await this.prisma.discussion.findMany({ where: { authorId: userId }, select: { id: true } });
        const discussionIds = userDiscussions.map(d => d.id);
        const userConversations = await this.prisma.conversation.findMany({
            where: { OR: [{ participant1Id: userId }, { participant2Id: userId }] },
            select: { id: true }
        });
        const conversationIds = userConversations.map(c => c.id);
        await this.prisma.$transaction([
            this.prisma.reaction.deleteMany({ where: { userId } }),
            this.prisma.reply.deleteMany({ where: { discussionId: { in: discussionIds } } }),
            this.prisma.reply.deleteMany({ where: { authorId: userId } }),
            this.prisma.message.deleteMany({ where: { conversationId: { in: conversationIds } } }),
            this.prisma.conversation.deleteMany({ where: { id: { in: conversationIds } } }),
            this.prisma.communityMember.deleteMany({ where: { userId } }),
            this.prisma.notification.deleteMany({ where: { userId } }),
            this.prisma.discussion.deleteMany({ where: { authorId: userId } }),
            this.prisma.user.delete({ where: { id: userId } }),
        ]);
        return { message: 'Tài khoản đã được xóa vĩnh viễn' };
    }
};
exports.UsersService = UsersService;
exports.UsersService = UsersService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], UsersService);
//# sourceMappingURL=users.service.js.map