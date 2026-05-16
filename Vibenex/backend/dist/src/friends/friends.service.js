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
exports.FriendsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const client_1 = require("@prisma/client");
const notifications_service_1 = require("../notifications/notifications.service");
let FriendsService = class FriendsService {
    prisma;
    notificationsService;
    constructor(prisma, notificationsService) {
        this.prisma = prisma;
        this.notificationsService = notificationsService;
    }
    async sendRequest(senderId, receiverId) {
        if (senderId === receiverId) {
            throw new common_1.BadRequestException('Cannot send friend request to yourself');
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
            throw new common_1.BadRequestException('Friend request already exists or already friends');
        }
        const request = await this.prisma.friendRequest.create({
            data: {
                senderId,
                receiverId
            }
        });
        const sender = await this.prisma.user.findUnique({ where: { id: senderId } });
        await this.notificationsService.createNotification(receiverId, 'FOLLOW', 'Yêu cầu kết bạn', `${sender?.name || sender?.username} đã gửi lời mời kết bạn.`, { followerId: senderId, requestId: request.id });
        return request;
    }
    async acceptRequest(requestId, userId) {
        const request = await this.prisma.friendRequest.findUnique({
            where: { id: requestId }
        });
        if (!request)
            throw new common_1.NotFoundException('Friend request not found');
        if (request.receiverId !== userId)
            throw new common_1.BadRequestException('Not authorized to accept this request');
        if (request.status !== client_1.FriendStatus.PENDING)
            throw new common_1.BadRequestException('Request is not pending');
        return this.prisma.friendRequest.update({
            where: { id: requestId },
            data: { status: client_1.FriendStatus.ACCEPTED }
        });
    }
    async rejectRequest(requestId, userId) {
        const request = await this.prisma.friendRequest.findUnique({
            where: { id: requestId }
        });
        if (!request)
            throw new common_1.NotFoundException('Friend request not found');
        if (request.receiverId !== userId)
            throw new common_1.BadRequestException('Not authorized to reject this request');
        if (request.status !== client_1.FriendStatus.PENDING)
            throw new common_1.BadRequestException('Request is not pending');
        return this.prisma.friendRequest.update({
            where: { id: requestId },
            data: { status: client_1.FriendStatus.REJECTED }
        });
    }
    async removeFriend(userId, friendId) {
        const request = await this.prisma.friendRequest.findFirst({
            where: {
                status: client_1.FriendStatus.ACCEPTED,
                OR: [
                    { senderId: userId, receiverId: friendId },
                    { senderId: friendId, receiverId: userId }
                ]
            }
        });
        if (!request)
            throw new common_1.NotFoundException('Friendship not found');
        return this.prisma.friendRequest.delete({
            where: { id: request.id }
        });
    }
    async getFriends(userId) {
        const requests = await this.prisma.friendRequest.findMany({
            where: {
                status: client_1.FriendStatus.ACCEPTED,
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
    async getPendingRequests(userId) {
        return this.prisma.friendRequest.findMany({
            where: {
                receiverId: userId,
                status: client_1.FriendStatus.PENDING
            },
            include: {
                sender: { select: { id: true, name: true, username: true, avatar: true } }
            }
        });
    }
};
exports.FriendsService = FriendsService;
exports.FriendsService = FriendsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService,
        notifications_service_1.NotificationsService])
], FriendsService);
//# sourceMappingURL=friends.service.js.map