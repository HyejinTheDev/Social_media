import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { UpdateUserDto } from './dto/update-user.dto';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async getProfile(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
    });
    if (!user) throw new NotFoundException('Không tìm thấy người dùng');
    return this.sanitize(user);
  }

  async getProfileById(userId: string, currentUserId?: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
    });
    if (!user) throw new NotFoundException('Không tìm thấy người dùng');

    let isFollowing = false;
    if (currentUserId && currentUserId !== userId) {
      const follow = await this.prisma.follow.findUnique({
        where: {
          followerId_followingId: {
            followerId: currentUserId,
            followingId: userId,
          },
        },
      });
      isFollowing = !!follow;
    }

    return {
      ...this.sanitize(user),
      isFollowing,
      isOwnProfile: currentUserId === userId,
    };
  }

  async updateProfile(userId: string, dto: UpdateUserDto) {
    // Check username uniqueness if updating
    if (dto.username) {
      const existing = await this.prisma.user.findUnique({
        where: { username: dto.username },
      });
      if (existing && existing.id !== userId) {
        throw new ConflictException('Tên người dùng đã tồn tại');
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

  async updateAvatar(userId: string, filename: string) {
    const avatarUrl = `/uploads/avatars/${filename}`;
    const user = await this.prisma.user.update({
      where: { id: userId },
      data: { avatar: avatarUrl },
    });
    return this.sanitize(user);
  }

  async updateCover(userId: string, filename: string) {
    const coverUrl = `/uploads/covers/${filename}`;
    const user = await this.prisma.user.update({
      where: { id: userId },
      data: { coverPhoto: coverUrl },
    });
    return this.sanitize(user);
  }

  async searchUsers(query: string, currentUserId: string, page = 1, limit = 20) {
    const skip = (page - 1) * limit;
    const where = {
      id: { not: currentUserId },
      OR: [
        { name: { contains: query, mode: 'insensitive' as const } },
        { username: { contains: query, mode: 'insensitive' as const } },
      ],
    };

    const [users, total] = await Promise.all([
      this.prisma.user.findMany({
        where,
        skip,
        take: limit,
        orderBy: { followersCount: 'desc' },
        select: {
          id: true,
          name: true,
          username: true,
          avatar: true,
          bio: true,
          isVerified: true,
          followersCount: true,
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

  private sanitize(user: any) {
    const { password, ...result } = user;
    return result;
  }
}
