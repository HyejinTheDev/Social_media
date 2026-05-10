import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ChatService {
  constructor(private prisma: PrismaService) {}

  private readonly userSelect = {
    id: true,
    name: true,
    username: true,
    avatar: true,
    isVerified: true,
  };

  async getOrCreateConversation(userId1: string, userId2: string) {
    // Always order IDs to prevent duplicates
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

    // Return with "otherUser" convenience field
    const otherUser = conversation.participant1Id === userId1
      ? conversation.participant2
      : conversation.participant1;

    return { ...conversation, otherUser };
  }

  async getConversations(userId: string) {
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

      // Count unread messages
      return {
        ...conv,
        otherUser,
      };
    });
  }

  async getMessages(conversationId: string, userId: string, page = 1, limit = 30) {
    // Verify user is participant
    const conversation = await this.prisma.conversation.findUnique({
      where: { id: conversationId },
    });
    if (!conversation) throw new NotFoundException('Cuộc trò chuyện không tồn tại');
    if (conversation.participant1Id !== userId && conversation.participant2Id !== userId) {
      throw new ForbiddenException('Bạn không thuộc cuộc trò chuyện này');
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
      messages: messages.reverse(), // oldest first for display
      total,
      page,
      totalPages: Math.ceil(total / limit),
    };
  }

  async sendMessage(conversationId: string, senderId: string, content: string, imageUrl?: string) {
    // Verify participation
    const conversation = await this.prisma.conversation.findUnique({
      where: { id: conversationId },
    });
    if (!conversation) throw new NotFoundException('Cuộc trò chuyện không tồn tại');
    if (conversation.participant1Id !== senderId && conversation.participant2Id !== senderId) {
      throw new ForbiddenException('Bạn không thuộc cuộc trò chuyện này');
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

  async markAsRead(conversationId: string, userId: string) {
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

  async getUnreadCount(conversationId: string, userId: string) {
    const count = await this.prisma.message.count({
      where: {
        conversationId,
        senderId: { not: userId },
        isRead: false,
      },
    });
    return { unreadCount: count };
  }

  async deleteMessage(messageId: string, userId: string) {
    const message = await this.prisma.message.findUnique({ where: { id: messageId } });
    if (!message) throw new NotFoundException('Tin nhắn không tồn tại');
    if (message.senderId !== userId) throw new ForbiddenException('Chỉ người gửi mới xóa được');

    await this.prisma.message.delete({ where: { id: messageId } });
    return { success: true };
  }
}
