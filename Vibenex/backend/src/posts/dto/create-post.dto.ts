import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, MaxLength } from 'class-validator';

export class CreatePostDto {
  @ApiProperty({ description: 'Post text content', example: 'Hello world', required: false })
  @IsString()
  @IsOptional()
  @MaxLength(1000)
  content?: string;

  @ApiPropertyOptional({ description: 'Images (max 10)', type: 'array', items: { type: 'string', format: 'binary' } })
  @IsOptional()
  images?: any[];

  @ApiPropertyOptional({ description: 'Video file', type: 'string', format: 'binary' })
  @IsOptional()
  video?: any;

  @ApiPropertyOptional({ description: 'Video thumbnail (optional)', type: 'string', format: 'binary' })
  @IsOptional()
  thumbnail?: any;
}
