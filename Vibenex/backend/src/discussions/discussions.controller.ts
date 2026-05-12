import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Query,
  UseGuards,
  Request,
} from '@nestjs/common';
import { DiscussionsService } from './discussions.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller()
@UseGuards(JwtAuthGuard)
export class DiscussionsController {
  constructor(private readonly discussionsService: DiscussionsService) {}

  // GET /channels/:channelId/discussions
  @Get('channels/:channelId/discussions')
  findByChannel(
    @Param('channelId') channelId: string,
    @Query('page') page = '1',
    @Query('limit') limit = '20',
  ) {
    return this.discussionsService.findByChannel(
      channelId,
      parseInt(page),
      parseInt(limit),
    );
  }

  // POST /channels/:channelId/discussions
  @Post('channels/:channelId/discussions')
  create(
    @Request() req,
    @Param('channelId') channelId: string,
    @Body() body: { content: string; imageUrls?: string[]; linkUrl?: string },
  ) {
    return this.discussionsService.create(channelId, req.user.sub, body);
  }

  // GET /discussions/:id
  @Get('discussions/:id')
  findOne(@Param('id') id: string) {
    return this.discussionsService.findById(id);
  }

  // GET /discussions/:discussionId/replies
  @Get('discussions/:discussionId/replies')
  getReplies(@Param('discussionId') discussionId: string) {
    return this.discussionsService.getReplies(discussionId);
  }

  // POST /discussions/:discussionId/replies
  @Post('discussions/:discussionId/replies')
  createReply(
    @Request() req,
    @Param('discussionId') discussionId: string,
    @Body() body: { content: string; parentId?: string },
  ) {
    return this.discussionsService.createReply(discussionId, req.user.sub, body);
  }
}
