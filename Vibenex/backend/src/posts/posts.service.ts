import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreatePostDto } from './dto/create-post.dto';
import { MediaType } from '@prisma/client';

@Injectable()
export class PostsService {
  constructor(private prisma: PrismaService) {}

  async create(userId: string, dto: CreatePostDto, fileUrls: { images?: string[], video?: string, thumbnail?: string }) {
    let mediaType: MediaType = MediaType.TEXT;
    if (fileUrls.video) mediaType = MediaType.VIDEO;
    else if (fileUrls.images && fileUrls.images.length > 0) mediaType = MediaType.IMAGE;

    return this.prisma.post.create({
      data: {
        content: dto.content,
        authorId: userId,
        mediaType,
        imageUrls: fileUrls.images || [],
        videoUrl: fileUrls.video || null,
        videoThumbnailUrl: fileUrls.thumbnail || null,
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

  async getFeed(page = 1, limit = 10) {
    const skip = (page - 1) * limit;
    
    const [posts, total] = await Promise.all([
      this.prisma.post.findMany({
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          author: {
            select: { id: true, name: true, username: true, avatar: true, isVerified: true },
          },
        },
      }),
      this.prisma.post.count(),
    ]);

    return {
      posts,
      total,
      page,
      totalPages: Math.ceil(total / limit),
    };
  }

  async getPostById(id: string) {
    const post = await this.prisma.post.findUnique({
      where: { id },
      include: {
        author: {
          select: { id: true, name: true, username: true, avatar: true, isVerified: true },
        },
      },
    });

    if (!post) throw new NotFoundException('Bài viết không tồn tại');
    return post;
  }

  async getUserPosts(userId: string, page = 1, limit = 10) {
    const skip = (page - 1) * limit;

    const [posts, total] = await Promise.all([
      this.prisma.post.findMany({
        where: { authorId: userId },
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          author: {
            select: { id: true, name: true, username: true, avatar: true, isVerified: true },
          },
        },
      }),
      this.prisma.post.count({ where: { authorId: userId } }),
    ]);

    return {
      posts,
      total,
      page,
      totalPages: Math.ceil(total / limit),
    };
  }

  async remove(userId: string, postId: string) {
    const post = await this.prisma.post.findUnique({
      where: { id: postId },
    });

    if (!post) throw new NotFoundException('Bài viết không tồn tại');
    if (post.authorId !== userId) throw new ForbiddenException('Bạn không có quyền xóa bài viết này');

    await this.prisma.post.delete({ where: { id: postId } });
    return { success: true, message: 'Đã xóa bài viết' };
  }

  async toggleLike(userId: string, postId: string) {
    const post = await this.prisma.post.findUnique({ where: { id: postId } });
    if (!post) throw new NotFoundException('Bài viết không tồn tại');

    const existingLike = await this.prisma.like.findUnique({
      where: {
        postId_userId: { postId, userId }
      }
    });

    if (existingLike) {
      // Unlike
      await this.prisma.$transaction([
        this.prisma.like.delete({
          where: { postId_userId: { postId, userId } }
        }),
        this.prisma.post.update({
          where: { id: postId },
          data: { likesCount: { decrement: 1 } }
        })
      ]);
      return { liked: false };
    } else {
      // Like
      await this.prisma.$transaction([
        this.prisma.like.create({
          data: { postId, userId }
        }),
        this.prisma.post.update({
          where: { id: postId },
          data: { likesCount: { increment: 1 } }
        })
      ]);
      return { liked: true };
    }
  }

  async getLikeStatus(userId: string, postId: string) {
    const like = await this.prisma.like.findUnique({
      where: { postId_userId: { postId, userId } }
    });
    return { liked: !!like };
  }
}
