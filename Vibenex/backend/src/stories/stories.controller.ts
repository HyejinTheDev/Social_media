import { Controller, Get, Post, Body, UseGuards, Request } from '@nestjs/common';
import { StoriesService } from './stories.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('stories')
@UseGuards(JwtAuthGuard)
export class StoriesController {
  constructor(private readonly storiesService: StoriesService) {}

  @Get('feed')
  getFeed(@Request() req) {
    return this.storiesService.getFeed(req.user.sub);
  }

  @Post()
  createStory(@Request() req, @Body() body: { imageUrl?: string; videoUrl?: string }) {
    return this.storiesService.createStory(req.user.sub, body.imageUrl, body.videoUrl);
  }
}
