import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, MaxLength } from 'class-validator';

export class CreateCommentDto {
  @ApiProperty({ description: 'Nội dung bình luận', example: 'Bài viết hay quá!' })
  @IsString()
  @IsNotEmpty()
  @MaxLength(500)
  content: string;
}
