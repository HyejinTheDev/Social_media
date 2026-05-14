import { PrismaService } from '../prisma/prisma.service';
export declare class FriendsService {
    private prisma;
    constructor(prisma: PrismaService);
    sendRequest(senderId: string, receiverId: string): Promise<{
        id: string;
        createdAt: Date;
        senderId: string;
        receiverId: string;
        status: import("@prisma/client").$Enums.FriendStatus;
    }>;
    acceptRequest(requestId: string, userId: string): Promise<{
        id: string;
        createdAt: Date;
        senderId: string;
        receiverId: string;
        status: import("@prisma/client").$Enums.FriendStatus;
    }>;
    rejectRequest(requestId: string, userId: string): Promise<{
        id: string;
        createdAt: Date;
        senderId: string;
        receiverId: string;
        status: import("@prisma/client").$Enums.FriendStatus;
    }>;
    removeFriend(userId: string, friendId: string): Promise<{
        id: string;
        createdAt: Date;
        senderId: string;
        receiverId: string;
        status: import("@prisma/client").$Enums.FriendStatus;
    }>;
    getFriends(userId: string): Promise<{
        id: string;
        name: string;
        username: string;
        avatar: string | null;
    }[]>;
    getPendingRequests(userId: string): Promise<({
        sender: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        senderId: string;
        receiverId: string;
        status: import("@prisma/client").$Enums.FriendStatus;
    })[]>;
}
