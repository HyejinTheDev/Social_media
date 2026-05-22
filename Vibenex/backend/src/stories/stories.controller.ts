import { Controller, Get, Post, Delete, Body, Param, UseGuards, Request, UseInterceptors, UploadedFile } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiConsumes, ApiBody } from '@nestjs/swagger';
import { diskStorage } from 'multer';
import { extname } from 'path';
import { v4 as uuidv4 } from 'uuid';
import { StoriesService } from './stories.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

const storyStorage = {
  storage: diskStorage({
    destination: './uploads/stories',
    filename: (_, file, cb) => {
      const uniqueName = `${uuidv4()}${extname(file.originalname)}`;
      cb(null, uniqueName);
    },
  }),
  limits: { fileSize: 50 * 1024 * 1024 }, // 50MB for videos
  fileFilter: (_, file, cb) => {
    if (file.mimetype.startsWith('image/') || file.mimetype.startsWith('video/')) {
      cb(null, true);
    } else {
      cb(new Error('Chỉ hỗ trợ file ảnh hoặc video'), false);
    }
  },
};

@ApiTags('Stories')
@Controller('stories')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class StoriesController {
  constructor(private readonly storiesService: StoriesService) {}

  @Get('feed')
  @ApiOperation({ summary: 'Get story feed (active stories from friends)' })
  getFeed(@Request() req) {
    return this.storiesService.getFeed(req.user.sub);
  }

  @Get('me')
  @ApiOperation({ summary: 'Get my active stories with view details' })
  getMyStories(@Request() req) {
    return this.storiesService.getMyStories(req.user.sub);
  }

  @Post()
  @ApiOperation({ summary: 'Create a story' })
  createStory(@Request() req, @Body() body: { imageUrl?: string; videoUrl?: string; caption?: string }) {
    return this.storiesService.createStory(req.user.sub, body.imageUrl, body.videoUrl, body.caption);
  }

  @Post('upload')
  @UseInterceptors(FileInterceptor('file', storyStorage))
  @ApiOperation({ summary: 'Upload story media (image/video)' })
  @ApiConsumes('multipart/form-data')
  @ApiBody({ schema: { type: 'object', properties: { file: { type: 'string', format: 'binary' } } } })
  uploadMedia(@UploadedFile() file: Express.Multer.File) {
    return {
      url: `/uploads/stories/${file.filename}`,
      type: file.mimetype.startsWith('video/') ? 'video' : 'image',
    };
  }

  @Post(':id/view')
  @ApiOperation({ summary: 'Mark story as viewed' })
  viewStory(@Request() req, @Param('id') id: string) {
    return this.storiesService.viewStory(id, req.user.sub);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete own story' })
  deleteStory(@Request() req, @Param('id') id: string) {
    return this.storiesService.deleteStory(id, req.user.sub);
  }
}
