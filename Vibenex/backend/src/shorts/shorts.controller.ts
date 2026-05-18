import { Controller, Get, Post, Body, Param, Query, UseGuards, Request, UploadedFile, UseInterceptors } from '@nestjs/common';
import { ShortsService } from './shorts.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { FileInterceptor } from '@nestjs/platform-express';
import { memoryStorage } from 'multer';
import { CloudinaryService } from '../cloudinary/cloudinary.service';

const uploadOptions = {
  storage: memoryStorage(),
  limits: { fileSize: 100 * 1024 * 1024 }, // 100MB for shorts
  fileFilter: (_, file, cb) => {
    if (file.mimetype.startsWith('image/') || file.mimetype.startsWith('video/')) {
      cb(null, true);
    } else {
      cb(new Error('Chỉ hỗ trợ file ảnh hoặc video'), false);
    }
  },
};

@ApiTags('shorts')
@Controller('shorts')
export class ShortsController {
  constructor(
    private readonly shortsService: ShortsService,
    private readonly cloudinaryService: CloudinaryService
  ) {}

  @Get('feed')
  @ApiOperation({ summary: 'Get shorts feed' })
  getFeed(
    @Query('page') page: string = '1',
    @Query('limit') limit: string = '10'
  ) {
    return this.shortsService.getFeed(parseInt(page, 10), parseInt(limit, 10));
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get short by id' })
  getShortById(@Param('id') id: string) {
    return this.shortsService.getShortById(id);
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Post()
  @ApiOperation({ summary: 'Create a new short' })
  createShort(
    @Request() req,
    @Body() body: { videoUrl: string; caption?: string; thumbnailUrl?: string }
  ) {
    return this.shortsService.createShort(req.user.sub, body.videoUrl, body.caption, body.thumbnailUrl);
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Post('upload')
  @ApiOperation({ summary: 'Upload short video or thumbnail to Cloudinary' })
  @UseInterceptors(FileInterceptor('file', uploadOptions))
  async uploadMedia(@UploadedFile() file: Express.Multer.File) {
    const isVideo = file.mimetype.startsWith('video/');
    const result = isVideo 
      ? await this.cloudinaryService.uploadVideo(file)
      : await this.cloudinaryService.uploadImage(file);
      
    return {
      url: result.secure_url,
      type: isVideo ? 'video' : 'image',
    };
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Post(':id/like')
  @ApiOperation({ summary: 'Toggle like on a short' })
  toggleLike(@Request() req, @Param('id') id: string) {
    return this.shortsService.toggleLike(id, req.user.sub);
  }

  @Get(':id/comments')
  @ApiOperation({ summary: 'Get comments for a short' })
  getComments(@Param('id') id: string) {
    return this.shortsService.getComments(id);
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Post(':id/comments')
  @ApiOperation({ summary: 'Create a comment on a short' })
  createComment(
    @Request() req,
    @Param('id') id: string,
    @Body() body: { content: string; parentId?: string }
  ) {
    return this.shortsService.createComment(id, req.user.sub, body.content, body.parentId);
  }
}
