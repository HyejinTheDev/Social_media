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
exports.ChatService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let ChatService = class ChatService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    userSelect = {
        id: true,
        name: true,
        username: true,
        avatar: true,
        isVerified: true,
    };
    async getOrCreateConversation(userId1, userId2) {
        const [p1, p2] = [userId1, userId2].sort();
        let conversation = await this.prisma.conversation.findUnique({
            where: { participant1Id_participant2Id: { participant1Id: p1, participant2Id: p2 } },
            include: {
                participant1: { select: this.userSelect },
                participant2: { select: this.userSelect },
            },
        });
        if (!conversation) {
            conversation = await this.prisma.conversation.create({
                data: { participant1Id: p1, participant2Id: p2 },
                include: {
                    participant1: { select: this.userSelect },
                    participant2: { select: this.userSelect },
                },
            });
        }
        const otherUser = conversation.participant1Id === userId1
            ? conversation.participant2
            : conversation.participant1;
        return { ...conversation, otherUser };
    }
    async getConversations(userId) {
        const conversations = await this.prisma.conversation.findMany({
            where: {
                OR: [
                    { participant1Id: userId },
                    { participant2Id: userId },
                ],
            },
            include: {
                participant1: { select: this.userSelect },
                participant2: { select: this.userSelect },
            },
            orderBy: { lastMessageAt: { sort: 'desc', nulls: 'last' } },
        });
        return conversations.map(conv => {
            const otherUser = conv.participant1Id === userId
                ? conv.participant2
                : conv.participant1;
            return {
                ...conv,
                otherUser,
            };
        });
    }
    async getMessages(conversationId, userId, page = 1, limit = 30) {
        const conversation = await this.prisma.conversation.findUnique({
            where: { id: conversationId },
        });
        if (!conversation)
            throw new common_1.NotFoundException('Cuộc trò chuyện không tồn tại');
        if (conversation.participant1Id !== userId && conversation.participant2Id !== userId) {
            throw new common_1.ForbiddenException('Bạn không thuộc cuộc trò chuyện này');
        }
        const skip = (page - 1) * limit;
        const [messages, total] = await Promise.all([
            this.prisma.message.findMany({
                where: { conversationId },
                orderBy: { createdAt: 'desc' },
                skip,
                take: limit,
                include: {
                    sender: { select: this.userSelect },
                },
            }),
            this.prisma.message.count({ where: { conversationId } }),
        ]);
        return {
            messages: messages.reverse(),
            total,
            page,
            totalPages: Math.ceil(total / limit),
        };
    }
    async sendMessage(conversationId, senderId, content, imageUrl) {
        const conversation = await this.prisma.conversation.findUnique({
            where: { id: conversationId },
        });
        if (!conversation)
            throw new common_1.NotFoundException('Cuộc trò chuyện không tồn tại');
        if (conversation.participant1Id !== senderId && conversation.participant2Id !== senderId) {
            throw new common_1.ForbiddenException('Bạn không thuộc cuộc trò chuyện này');
        }
        const [message] = await this.prisma.$transaction([
            this.prisma.message.create({
                data: {
                    conversationId,
                    senderId,
                    content,
                    imageUrl,
                },
                include: {
                    sender: { select: this.userSelect },
                },
            }),
            this.prisma.conversation.update({
                where: { id: conversationId },
                data: {
                    lastMessage: content || '📷 Ảnh',
                    lastMessageAt: new Date(),
                },
            }),
        ]);
        return message;
    }
    async markAsRead(conversationId, userId) {
        await this.prisma.message.updateMany({
            where: {
                conversationId,
                senderId: { not: userId },
                isRead: false,
            },
            data: { isRead: true },
        });
        return { success: true };
    }
    async getUnreadCount(conversationId, userId) {
        const count = await this.prisma.message.count({
            where: {
                conversationId,
                senderId: { not: userId },
                isRead: false,
            },
        });
        return { unreadCount: count };
    }
    async deleteMessage(messageId, userId) {
        const message = await this.prisma.message.findUnique({ where: { id: messageId } });
        if (!message)
            throw new common_1.NotFoundException('Tin nhắn không tồn tại');
        if (message.senderId !== userId)
            throw new common_1.ForbiddenException('Chỉ người gửi mới xóa được');
        await this.prisma.message.delete({ where: { id: messageId } });
        return { success: true };
    }
};
exports.ChatService = ChatService;
exports.ChatService = ChatService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], ChatService);
//# sourceMappingURL=chat.service.js.map