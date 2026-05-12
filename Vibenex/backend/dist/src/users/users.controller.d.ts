import { UsersService } from './users.service';
import { UpdateUserDto } from './dto/update-user.dto';
export declare class UsersController {
    private usersService;
    constructor(usersService: UsersService);
    getMyProfile(req: any): Promise<any>;
    updateProfile(req: any, dto: UpdateUserDto): Promise<any>;
    uploadAvatar(req: any, file: Express.Multer.File): Promise<any>;
    uploadCover(req: any, file: Express.Multer.File): Promise<any>;
    searchUsers(req: any, query: string, page?: string): Promise<{
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
    getUserById(id: string, req: any): Promise<any>;
    deleteAccount(req: any): Promise<{
        message: string;
    }>;
}
