import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ReactionsService {
  constructor(private prisma: PrismaService) {}

  // Toggle reaction on a discussion
  async toggleDiscussionReaction(discussionId: string, userId: string, emoji: string) {
    const discussion = await this.prisma.discussion.findUnique({ where: { id: discussionId } });
    if (!discussion) throw new NotFoundException('Discussion not found');

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
    } else {
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

  // Toggle reaction on a reply
  async toggleReplyReaction(replyId: string, userId: string, emoji: string) {
    const reply = await this.prisma.reply.findUnique({ where: { id: replyId } });
    if (!reply) throw new NotFoundException('Reply not found');

    const existing = await this.prisma.reaction.findUnique({
      where: { userId_replyId_emoji: { userId, replyId, emoji } },
    });

    if (existing) {
      await this.prisma.reaction.delete({ where: { id: existing.id } });
      return { reacted: false, emoji };
    } else {
      await this.prisma.reaction.create({
        data: { userId, replyId, emoji },
      });
      return { reacted: true, emoji };
    }
  }

  // Get reaction summary for a discussion
  async getDiscussionReactions(discussionId: string, userId?: string) {
    const reactions = await this.prisma.reaction.findMany({
      where: { discussionId },
      include: {
        user: { select: { id: true, name: true, username: true, avatar: true } },
      },
    });

    // Group by emoji
    const summary = this.groupReactions(reactions, userId);
    return summary;
  }

  // Get reaction summary for a reply
  async getReplyReactions(replyId: string, userId?: string) {
    const reactions = await this.prisma.reaction.findMany({
      where: { replyId },
      include: {
        user: { select: { id: true, name: true, username: true, avatar: true } },
      },
    });

    const summary = this.groupReactions(reactions, userId);
    return summary;
  }

  private groupReactions(reactions: any[], currentUserId?: string) {
    const emojiMap = new Map<string, { emoji: string; count: number; reacted: boolean; users: any[] }>();

    for (const reaction of reactions) {
      if (!emojiMap.has(reaction.emoji)) {
        emojiMap.set(reaction.emoji, {
          emoji: reaction.emoji,
          count: 0,
          reacted: false,
          users: [],
        });
      }
      const entry = emojiMap.get(reaction.emoji)!;
      entry.count++;
      entry.users.push(reaction.user);
      if (currentUserId && reaction.userId === currentUserId) {
        entry.reacted = true;
      }
    }

    return Array.from(emojiMap.values());
  }
}
