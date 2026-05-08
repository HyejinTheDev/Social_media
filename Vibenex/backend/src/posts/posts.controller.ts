import {
  Controller, Get, Post, Body, Param, Delete, Query,
  UseGuards, Request, UseInterceptors, UploadedFiles, ParseIntPipe
} from '@nestjs/common';
import { PostsService } from './posts.service';
import { CreatePostDto } from './dto/create-post.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiConsumes, ApiBody } from '@nestjs/swagger';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname } from 'path';
import { v4 as uuidv4 } from 'uuid';

const storage = diskStorage({
  destination: './uploads/posts',
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

@ApiTags('Posts')
@Controller('posts')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class PostsController {
  constructor(private readonly postsService: PostsService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new post' })
  @ApiConsumes('multipart/form-data')
  @UseInterceptors(FileFieldsInterceptor([
    { name: 'images', maxCount: 10 },
    { name: 'video', maxCount: 1 },
    { name: 'thumbnail', maxCount: 1 },
  ], { storage, fileFilter, limits: { fileSize: 50 * 1024 * 1024 } })) // 50MB limit
  create(
    @Request() req: any,
    @Body() createPostDto: CreatePostDto,
    @UploadedFiles() files: { images?: Express.Multer.File[], video?: Express.Multer.File[], thumbnail?: Express.Multer.File[] }
  ) {
    const fileUrls: any = {};
    
    if (files?.images) {
      fileUrls.images = files.images.map(f => `/uploads/posts/${f.filename}`);
    }
    if (files?.video) {
      fileUrls.video = `/uploads/posts/${files.video[0].filename}`;
    }
    if (files?.thumbnail) {
      fileUrls.thumbnail = `/uploads/posts/${files.thumbnail[0].filename}`;
    }

    return this.postsService.create(req.user.sub, createPostDto, fileUrls);
  }

  @Get()
  @ApiOperation({ summary: 'Get feed posts' })
  findAll(
    @Query('page') page?: string,
    @Query('limit') limit?: string,
  ) {
    return this.postsService.getFeed(
      page ? parseInt(page, 10) : 1,
      limit ? parseInt(limit, 10) : 10
    );
  }

  @Get('user/:userId')
  @ApiOperation({ summary: 'Get user posts' })
  findByUser(
    @Param('userId') userId: string,
    @Query('page') page?: string,
    @Query('limit') limit?: string,
  ) {
    return this.postsService.getUserPosts(
      userId,
      page ? parseInt(page, 10) : 1,
      limit ? parseInt(limit, 10) : 10
    );
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get post by ID' })
  findOne(@Param('id') id: string) {
    return this.postsService.getPostById(id);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a post' })
  remove(@Request() req: any, @Param('id') id: string) {
    return this.postsService.remove(req.user.sub, id);
  }

  @Post(':id/like')
  @ApiOperation({ summary: 'Toggle like status for a post' })
  toggleLike(@Request() req: any, @Param('id') id: string) {
    return this.postsService.toggleLike(req.user.sub, id);
  }

  @Get(':id/like-status')
  @ApiOperation({ summary: 'Check if current user liked a post' })
  getLikeStatus(@Request() req: any, @Param('id') id: string) {
    return this.postsService.getLikeStatus(req.user.sub, id);
  }
}
