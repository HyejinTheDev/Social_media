import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString, MaxLength } from 'class-validator';

export class CreateStoryDto {
  @ApiPropertyOptional({ description: 'Story caption (optional)', example: 'Beautiful sunset 🌅' })
  @IsOptional()
  @IsString()
  @MaxLength(100)
  caption?: string;
}
