import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { FriendStatus } from '@prisma/client';

@Injectable()
export class FriendsService {
  constructor(private prisma: PrismaService) {}

  async sendRequest(senderId: string, receiverId: string) {
    if (senderId === receiverId) {
      throw new BadRequestException('Cannot send friend request to yourself');
    }

    const existingRequest = await this.prisma.friendRequest.findFirst({
      where: {
        OR: [
          { senderId, receiverId },
          { senderId: receiverId, receiverId: senderId }
        ]
      }
    });

    if (existingRequest) {
      throw new BadRequestException('Friend request already exists or already friends');
    }

    return this.prisma.friendRequest.create({
      data: {
        senderId,
        receiverId
      }
    });
  }

  async acceptRequest(requestId: string, userId: string) {
    const request = await this.prisma.friendRequest.findUnique({
      where: { id: requestId }
    });

    if (!request) throw new NotFoundException('Friend request not found');
    if (request.receiverId !== userId) throw new BadRequestException('Not authorized to accept this request');
    if (request.status !== FriendStatus.PENDING) throw new BadRequestException('Request is not pending');

    return this.prisma.friendRequest.update({
      where: { id: requestId },
      data: { status: FriendStatus.ACCEPTED }
    });
  }

  async rejectRequest(requestId: string, userId: string) {
    const request = await this.prisma.friendRequest.findUnique({
      where: { id: requestId }
    });

    if (!request) throw new NotFoundException('Friend request not found');
    if (request.receiverId !== userId) throw new BadRequestException('Not authorized to reject this request');
    if (request.status !== FriendStatus.PENDING) throw new BadRequestException('Request is not pending');

    return this.prisma.friendRequest.update({
      where: { id: requestId },
      data: { status: FriendStatus.REJECTED }
    });
  }

  async removeFriend(userId: string, friendId: string) {
    const request = await this.prisma.friendRequest.findFirst({
      where: {
        status: FriendStatus.ACCEPTED,
        OR: [
          { senderId: userId, receiverId: friendId },
          { senderId: friendId, receiverId: userId }
        ]
      }
    });

    if (!request) throw new NotFoundException('Friendship not found');

    return this.prisma.friendRequest.delete({
      where: { id: request.id }
    });
  }

  async getFriends(userId: string) {
    const requests = await this.prisma.friendRequest.findMany({
      where: {
        status: FriendStatus.ACCEPTED,
        OR: [
          { senderId: userId },
          { receiverId: userId }
        ]
      },
      include: {
        sender: { select: { id: true, name: true, username: true, avatar: true } },
        receiver: { select: { id: true, name: true, username: true, avatar: true } }
      }
    });

    return requests.map(req => req.senderId === userId ? req.receiver : req.sender);
  }

  async getPendingRequests(userId: string) {
    return this.prisma.friendRequest.findMany({
      where: {
        receiverId: userId,
        status: FriendStatus.PENDING
      },
      include: {
        sender: { select: { id: true, name: true, username: true, avatar: true } }
      }
    });
  }
}
