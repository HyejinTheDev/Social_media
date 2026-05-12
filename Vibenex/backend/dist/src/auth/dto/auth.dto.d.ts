export declare class RegisterDto {
    name: string;
    username: string;
    email: string;
    password: string;
}
export declare class LoginDto {
    email: string;
    password: string;
}
export declare class RefreshTokenDto {
    refreshToken: string;
}
export declare class ForgotPasswordDto {
    email: string;
}
export declare class ChangePasswordDto {
    oldPassword: string;
    newPassword: string;
}
