import { FriendsService } from './friends.service';
export declare class FriendsController {
    private readonly friendsService;
    constructor(friendsService: FriendsService);
    sendRequest(req: any, receiverId: string): Promise<{
        id: string;
        createdAt: Date;
        senderId: string;
        receiverId: string;
        status: import("@prisma/client").$Enums.FriendStatus;
    }>;
    acceptRequest(req: any, requestId: string): Promise<{
        id: string;
        createdAt: Date;
        senderId: string;
        receiverId: string;
        status: import("@prisma/client").$Enums.FriendStatus;
    }>;
    rejectRequest(req: any, requestId: string): Promise<{
        id: string;
        createdAt: Date;
        senderId: string;
        receiverId: string;
        status: import("@prisma/client").$Enums.FriendStatus;
    }>;
    removeFriend(req: any, friendId: string): Promise<{
        id: string;
        createdAt: Date;
        senderId: string;
        receiverId: string;
        status: import("@prisma/client").$Enums.FriendStatus;
    }>;
    getFriends(req: any): Promise<{
        id: string;
        name: string;
        username: string;
        avatar: string | null;
    }[]>;
    getPendingRequests(req: any): Promise<({
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
