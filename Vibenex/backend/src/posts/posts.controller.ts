import {
  Controller,
  Get,
  Post,
  Delete,
  Body,
  Param,
  Query,
  UseGuards,
  Request,
} from '@nestjs/common';
import { PostsService } from './posts.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { FileInterceptor, FilesInterceptor } from '@nestjs/platform-express';
import { UploadedFile, UploadedFiles, UseInterceptors } from '@nestjs/common';
import { diskStorage } from 'multer';
import { extname } from 'path';
import { v4 as uuidv4 } from 'uuid';

const createStorage = (destination: string) => ({
  storage: diskStorage({
    destination: `./uploads/${destination}`,
    filename: (_, file, cb) => {
      const uniqueName = `${uuidv4()}${extname(file.originalname)}`;
      cb(null, uniqueName);
    },
  }),
  limits: { fileSize: 50 * 1024 * 1024 }, // 50MB
  fileFilter: (_, file, cb) => {
    if (file.mimetype.startsWith('image/') || file.mimetype.startsWith('video/')) {
      cb(null, true);
    } else {
      cb(new Error('Chỉ hỗ trợ file ảnh hoặc video'), false);
    }
  },
});

@Controller('posts')
@UseGuards(JwtAuthGuard)
export class PostsController {
  constructor(private readonly postsService: PostsService) {}

  @Get('feed')
  getFeed(@Query('page') page = '1', @Query('limit') limit = '10') {
    return this.postsService.getFeed(parseInt(page), parseInt(limit));
  }

  @Get('user/:userId')
  getUserPosts(
    @Param('userId') userId: string,
    @Query('page') page = '1',
    @Query('limit') limit = '10'
  ) {
    return this.postsService.getUserPosts(userId, parseInt(page), parseInt(limit));
  }

  @Get(':id')
  getPostById(@Param('id') id: string) {
    return this.postsService.getPostById(id);
  }

  @Post()
  createPost(
    @Request() req,
    @Body() body: { content: string; imageUrls?: string[]; videoUrl?: string }
  ) {
    return this.postsService.createPost(
      req.user.sub,
      body.content,
      body.imageUrls,
      body.videoUrl
    );
  }

  @Post('upload')
  @UseInterceptors(FileInterceptor('file', createStorage('posts')))
  uploadMedia(@UploadedFile() file: Express.Multer.File) {
    return {
      url: `/uploads/posts/${file.filename}`,
      type: file.mimetype.startsWith('video/') ? 'video' : 'image',
    };
  }

  @Delete(':id')
  deletePost(@Request() req, @Param('id') id: string) {
    return this.postsService.deletePost(id, req.user.sub);
  }

  @Post(':id/like')
  toggleLike(@Request() req, @Param('id') id: string) {
    return this.postsService.toggleLike(id, req.user.sub);
  }

  @Get(':id/comments')
  getComments(@Param('id') id: string) {
    return this.postsService.getComments(id);
  }

  @Post(':id/comments')
  createComment(
    @Request() req,
    @Param('id') id: string,
    @Body() body: { content: string; parentId?: string }
  ) {
    return this.postsService.createComment(
      id,
      req.user.sub,
      body.content,
      body.parentId
    );
  }
}
