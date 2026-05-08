import { IsEmail, IsNotEmpty, IsString, MinLength, Matches } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class RegisterDto {
  @ApiProperty({ example: 'John Doe' })
  @IsNotEmpty({ message: 'Vui lòng nhập họ và tên' })
  @IsString({ message: 'Họ và tên không hợp lệ' })
  name: string;

  @ApiProperty({ example: 'johndoe' })
  @IsNotEmpty({ message: 'Vui lòng nhập tên người dùng' })
  @IsString({ message: 'Tên người dùng không hợp lệ' })
  @Matches(/^[a-z0-9_]{3,20}$/, {
    message: 'Tên người dùng phải 3-20 ký tự, chỉ chữ thường, số và _',
  })
  username: string;

  @ApiProperty({ example: 'john@example.com' })
  @IsEmail({}, { message: 'Email không hợp lệ' })
  email: string;

  @ApiProperty({ example: 'password123' })
  @IsNotEmpty({ message: 'Vui lòng nhập mật khẩu' })
  @MinLength(8, { message: 'Mật khẩu phải có ít nhất 8 ký tự' })
  password: string;
}

export class LoginDto {
  @ApiProperty({ example: 'john@example.com' })
  @IsEmail({}, { message: 'Email không hợp lệ' })
  email: string;

  @ApiProperty({ example: 'password123' })
  @IsNotEmpty({ message: 'Vui lòng nhập mật khẩu' })
  password: string;
}

export class RefreshTokenDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  refreshToken: string;
}

export class ForgotPasswordDto {
  @ApiProperty({ example: 'john@example.com' })
  @IsEmail({}, { message: 'Email không hợp lệ' })
  email: string;
}
