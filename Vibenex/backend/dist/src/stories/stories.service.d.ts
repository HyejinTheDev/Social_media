import { PrismaService } from '../prisma/prisma.service';
export declare class StoriesService {
    private prisma;
    constructor(prisma: PrismaService);
    createStory(userId: string, imageUrl?: string, videoUrl?: string): Promise<{
        author: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
    } & {
        id: string;
        createdAt: Date;
        authorId: string;
        imageUrl: string | null;
        videoUrl: string | null;
        expiresAt: Date;
    }>;
    getFeed(userId: string): Promise<({
        author: {
            id: string;
            name: string;
            username: string;
            avatar: string | null;
            isVerified: boolean;
        };
    } & {
        id: string;
        createdAt: Date;
        authorId: string;
        imageUrl: string | null;
        videoUrl: string | null;
        expiresAt: Date;
    })[]>;
}
