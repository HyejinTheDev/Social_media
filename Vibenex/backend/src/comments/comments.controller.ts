import { Controller, Get, Post, Body, Param, Delete, Query, UseGuards, Request } from '@nestjs/common';
import { CommentsService } from './comments.service';
import { CreateCommentDto } from './dto/create-comment.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';

@ApiTags('Comments')
@Controller()
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}

  @Post('posts/:postId/comments')
  @ApiOperation({ summary: 'Add a comment to a post' })
  create(
    @Request() req: any,
    @Param('postId') postId: string,
    @Body() createCommentDto: CreateCommentDto
  ) {
    return this.commentsService.create(req.user.sub, postId, createCommentDto);
  }

  @Get('posts/:postId/comments')
  @ApiOperation({ summary: 'Get comments of a post' })
  getComments(
    @Param('postId') postId: string,
    @Query('page') page?: string,
    @Query('limit') limit?: string,
  ) {
    return this.commentsService.getComments(
      postId,
      page ? parseInt(page, 10) : 1,
      limit ? parseInt(limit, 10) : 20
    );
  }

  @Delete('comments/:id')
  @ApiOperation({ summary: 'Delete a comment' })
  remove(@Request() req: any, @Param('id') id: string) {
    return this.commentsService.remove(req.user.sub, id);
  }
}
