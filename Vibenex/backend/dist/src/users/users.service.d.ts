import { PrismaService } from '../prisma/prisma.service';
import { UpdateUserDto } from './dto/update-user.dto';
export declare class UsersService {
    private prisma;
    constructor(prisma: PrismaService);
    getProfile(userId: string): Promise<any>;
    getProfileById(userId: string, currentUserId?: string): Promise<any>;
    updateProfile(userId: string, dto: UpdateUserDto): Promise<any>;
    updateAvatar(userId: string, filename: string): Promise<any>;
    updateCover(userId: string, filename: string): Promise<any>;
    searchUsers(query: string, currentUserId: string, page?: number, limit?: number): Promise<{
        users: {
            name: string;
            username: string;
            id: string;
            bio: string | null;
            avatar: string | null;
            reputation: number;
            isVerified: boolean;
        }[];
        total: number;
        page: number;
        totalPages: number;
    }>;
    private sanitize;
    deleteAccount(userId: string): Promise<{
        message: string;
    }>;
}
