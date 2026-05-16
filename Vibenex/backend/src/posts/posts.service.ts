import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { NotificationsService } from '../notifications/notifications.service';
import { NotificationType } from '@prisma/client';

@Injectable()
export class PostsService {
  constructor(
    private prisma: PrismaService,
    private notificationsService: NotificationsService,
  ) {}

  async getFeed(page: number, limit: number) {
    const skip = (page - 1) * limit;
    
    const [posts, total] = await Promise.all([
      this.prisma.post.findMany({
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          author: {
            select: {
              id: true,
              name: true,
              username: true,
              avatar: true,
            }
          },
          likes: true, // We might need to map this to check if current user liked it
          _count: {
            select: {
              likes: true,
              comments: true,
            }
          }
        }
      }),
      this.prisma.post.count()
    ]);

    return {
      data: posts,
      meta: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit)
      }
    };
  }

  async getUserPosts(userId: string, page: number, limit: number) {
    const skip = (page - 1) * limit;
    const [posts, total] = await Promise.all([
      this.prisma.post.findMany({
        where: { authorId: userId },
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          author: {
            select: { id: true, name: true, username: true, avatar: true }
          },
          likes: true,
          _count: { select: { likes: true, comments: true } }
        }
      }),
      this.prisma.post.count({ where: { authorId: userId } })
    ]);

    return {
      data: posts,
      meta: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit)
      }
    };
  }

  async createPost(authorId: string, content: string, imageUrls?: string[], videoUrl?: string) {
    return this.prisma.post.create({
      data: {
        content,
        authorId,
        imageUrls: imageUrls || [],
        videoUrl,
      },
      include: {
        author: {
          select: {
            id: true,
            name: true,
            username: true,
            avatar: true,
          }
        }
      }
    });
  }

  async getPostById(id: string) {
    const post = await this.prisma.post.findUnique({
      where: { id },
      include: {
        author: {
          select: { id: true, name: true, username: true, avatar: true }
        },
        _count: {
          select: { likes: true, comments: true }
        }
      }
    });
    if (!post) throw new NotFoundException('Post not found');
    return post;
  }

  async deletePost(id: string, authorId: string) {
    const post = await this.prisma.post.findUnique({ where: { id } });
    if (!post) throw new NotFoundException('Post not found');
    if (post.authorId !== authorId) throw new NotFoundException('Unauthorized to delete this post');

    return this.prisma.post.delete({ where: { id } });
  }

  async toggleLike(postId: string, userId: string) {
    const existingLike = await this.prisma.postLike.findUnique({
      where: {
        postId_userId: { postId, userId }
      }
    });

    if (existingLike) {
      await this.prisma.postLike.delete({ where: { id: existingLike.id } });
      await this.prisma.post.update({
        where: { id: postId },
        data: { likeCount: { decrement: 1 } }
      });
      return { liked: false };
    } else {
      await this.prisma.postLike.create({
        data: { postId, userId }
      });
      const updatedPost = await this.prisma.post.update({
        where: { id: postId },
        data: { likeCount: { increment: 1 } },
        include: { author: true },
      });
      
      if (updatedPost.authorId !== userId) {
        const liker = await this.prisma.user.findUnique({ where: { id: userId } });
        await this.notificationsService.createNotification(
          updatedPost.authorId,
          'LIKE',
          'Lượt thích mới',
          `${liker?.name || liker?.username} đã thích bài viết của bạn.`,
          { postId }
        );
      }
      
      return { liked: true };
    }
  }

  async getComments(postId: string) {
    return this.prisma.comment.findMany({
      where: { postId },
      orderBy: { createdAt: 'asc' },
      include: {
        author: {
          select: { id: true, name: true, username: true, avatar: true }
        }
      }
    });
  }

  async createComment(postId: string, authorId: string, content: string, parentId?: string) {
    const comment = await this.prisma.comment.create({
      data: {
        content,
        postId,
        authorId,
        parentId
      },
      include: {
        author: {
          select: { id: true, name: true, username: true, avatar: true }
        }
      }
    });

    const post = await this.prisma.post.update({
      where: { id: postId },
      data: { commentCount: { increment: 1 } }
    });

    if (post.authorId !== authorId) {
      await this.notificationsService.createNotification(
        post.authorId,
        'COMMENT',
        'Bình luận mới',
        `${comment.author.name || comment.author.username} đã bình luận: "${content}"`,
        { postId, commentId: comment.id }
      );
    }

    return comment;
  }
}
