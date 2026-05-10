import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateCommentDto } from './dto/create-comment.dto';
import { NotificationsService } from '../notifications/notifications.service';
import { NotificationType } from '@prisma/client';

@Injectable()
export class CommentsService {
  constructor(
    private prisma: PrismaService,
    private notificationsService: NotificationsService,
  ) {}

  async create(userId: string, postId: string, dto: CreateCommentDto) {
    const post = await this.prisma.post.findUnique({ where: { id: postId } });
    if (!post) throw new NotFoundException('Bài viết không tồn tại');

    // Create comment and increment count in a transaction
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

    // Trigger notification if not commenting on own post
    if (post.authorId !== userId) {
      const commenter = await this.prisma.user.findUnique({ where: { id: userId }, select: { name: true } });
      let snippet = dto.content;
      if (snippet.length > 30) snippet = snippet.substring(0, 30) + '...';
      
      await this.notificationsService.createNotification(
        post.authorId,
        NotificationType.COMMENT,
        'Có bình luận mới',
        `${commenter?.name} đã bình luận: "${snippet}"`,
        { postId, commentId: comment.id }
      );
    }

    return comment;
  }

  async getComments(postId: string, page = 1, limit = 20) {
    const post = await this.prisma.post.findUnique({ where: { id: postId } });
    if (!post) throw new NotFoundException('Bài viết không tồn tại');

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

  async remove(userId: string, id: string) {
    const comment = await this.prisma.comment.findUnique({
      where: { id },
      include: { post: true }
    });

    if (!comment) throw new NotFoundException('Bình luận không tồn tại');
    if (comment.authorId !== userId) {
      throw new ForbiddenException('Bạn không có quyền xóa bình luận này');
    }

    // Delete comment and decrement count in a transaction
    await this.prisma.$transaction([
      this.prisma.comment.delete({ where: { id } }),
      this.prisma.post.update({
        where: { id: comment.postId },
        data: { commentsCount: { decrement: 1 } }
      })
    ]);

    return { success: true, message: 'Đã xóa bình luận' };
  }
}
