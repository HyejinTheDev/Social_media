import { Controller, Get, Post, Body, Param, Query, UseGuards, Request } from '@nestjs/common';
import { ShortsService } from './shorts.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';

@ApiTags('shorts')
@Controller('shorts')
export class ShortsController {
  constructor(private readonly shortsService: ShortsService) {}

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
