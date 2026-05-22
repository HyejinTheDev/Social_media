import { Controller, Post, Get, Param, Body, Query, UseGuards, Request } from '@nestjs/common';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { ReactionsService } from './reactions.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Reactions')
@Controller('reactions')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class ReactionsController {
  constructor(private readonly reactionsService: ReactionsService) {}

  @Post('discussions/:discussionId')
  @ApiOperation({ summary: 'Toggle emoji reaction on a discussion' })
  toggleDiscussionReaction(
    @Request() req,
    @Param('discussionId') discussionId: string,
    @Body() body: { emoji: string },
  ) {
    return this.reactionsService.toggleDiscussionReaction(discussionId, req.user.sub, body.emoji);
  }

  @Post('replies/:replyId')
  @ApiOperation({ summary: 'Toggle emoji reaction on a reply' })
  toggleReplyReaction(
    @Request() req,
    @Param('replyId') replyId: string,
    @Body() body: { emoji: string },
  ) {
    return this.reactionsService.toggleReplyReaction(replyId, req.user.sub, body.emoji);
  }

  @Get('discussions/:discussionId')
  @ApiOperation({ summary: 'Get reaction summary for a discussion' })
  getDiscussionReactions(
    @Request() req,
    @Param('discussionId') discussionId: string,
  ) {
    return this.reactionsService.getDiscussionReactions(discussionId, req.user.sub);
  }

  @Get('replies/:replyId')
  @ApiOperation({ summary: 'Get reaction summary for a reply' })
  getReplyReactions(
    @Request() req,
    @Param('replyId') replyId: string,
  ) {
    return this.reactionsService.getReplyReactions(replyId, req.user.sub);
  }
}
