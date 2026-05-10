import {
  Controller, Get, Post, Body, Param, Delete,
  UseGuards, Request, UseInterceptors, UploadedFile,
} from '@nestjs/common';
import { StoriesService } from './stories.service';
import { CreateStoryDto } from './dto/create-story.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiConsumes } from '@nestjs/swagger';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname } from 'path';
import { v4 as uuidv4 } from 'uuid';
import { MediaType } from '@prisma/client';

const storage = diskStorage({
  destination: './uploads/stories',
  filename: (_, file, cb) => {
    const uniqueName = `${uuidv4()}${extname(file.originalname)}`;
    cb(null, uniqueName);
  },
});

const fileFilter = (_, file, cb) => {
  if (file.mimetype.startsWith('image/') || file.mimetype.startsWith('video/')) {
    cb(null, true);
  } else {
    cb(new Error('Chỉ hỗ trợ file ảnh hoặc video'), false);
  }
};

@ApiTags('Stories')
@Controller('stories')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class StoriesController {
  constructor(private readonly storiesService: StoriesService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new story' })
  @ApiConsumes('multipart/form-data')
  @UseInterceptors(FileInterceptor('media', { storage, fileFilter, limits: { fileSize: 50 * 1024 * 1024 } }))
  create(
    @Request() req: any,
    @Body() dto: CreateStoryDto,
    @UploadedFile() file: Express.Multer.File,
  ) {
    if (!file) {
      throw new Error('Media file is required');
    }

    const fileUrl = `/uploads/stories/${file.filename}`;
    const mediaType = file.mimetype.startsWith('video/') ? MediaType.VIDEO : MediaType.IMAGE;

    return this.storiesService.create(req.user.sub, dto, fileUrl, mediaType);
  }

  @Get()
  @ApiOperation({ summary: 'Get active stories (grouped by author)' })
  getActiveStories(@Request() req: any) {
    return this.storiesService.getActiveStories(req.user.sub);
  }

  @Post(':id/view')
  @ApiOperation({ summary: 'Mark a story as viewed' })
  viewStory(@Request() req: any, @Param('id') id: string) {
    return this.storiesService.viewStory(req.user.sub, id);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a story (owner only)' })
  deleteStory(@Request() req: any, @Param('id') id: string) {
    return this.storiesService.deleteStory(req.user.sub, id);
  }

  @Get('me')
  @ApiOperation({ summary: 'Get my active stories with view details' })
  getMyStories(@Request() req: any) {
    return this.storiesService.getMyStories(req.user.sub);
  }
}
