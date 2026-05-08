import { IsOptional, IsString, MaxLength, Matches } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';

export class UpdateUserDto {
  @ApiPropertyOptional({ example: 'Nguyễn Văn A' })
  @IsOptional()
  @IsString({ message: 'Tên không hợp lệ' })
  name?: string;

  @ApiPropertyOptional({ example: 'nguyen_van_a' })
  @IsOptional()
  @IsString({ message: 'Tên người dùng không hợp lệ' })
  @Matches(/^[a-z0-9_]{3,20}$/, {
    message: 'Tên người dùng phải 3-20 ký tự, chỉ chữ thường, số và _',
  })
  username?: string;

  @ApiPropertyOptional({ example: 'Xin chào mọi người 👋' })
  @IsOptional()
  @IsString({ message: 'Bio không hợp lệ' })
  @MaxLength(150, { message: 'Bio tối đa 150 ký tự' })
  bio?: string;
}
