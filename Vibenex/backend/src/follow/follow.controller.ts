import {
  Controller, Post, Delete, Get, Param, Query,
  UseGuards, Request,
} from '@nestjs/common';
import { FollowService } from './follow.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';

@ApiTags('Follow')
@Controller('follow')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class FollowController {
  constructor(private readonly followService: FollowService) {}

  @Post(':userId')
  @ApiOperation({ summary: 'Follow a user' })
  follow(@Request() req: any, @Param('userId') userId: string) {
    return this.followService.follow(req.user.sub, userId);
  }

  @Delete(':userId')
  @ApiOperation({ summary: 'Unfollow a user' })
  unfollow(@Request() req: any, @Param('userId') userId: string) {
    return this.followService.unfollow(req.user.sub, userId);
  }

  @Get(':userId/status')
  @ApiOperation({ summary: 'Check follow status' })
  getStatus(@Request() req: any, @Param('userId') userId: string) {
    return this.followService.getFollowStatus(req.user.sub, userId);
  }

  @Get(':userId/followers')
  @ApiOperation({ summary: 'Get followers of a user' })
  getFollowers(
    @Param('userId') userId: string,
    @Query('page') page?: string,
  ) {
    return this.followService.getFollowers(userId, page ? parseInt(page, 10) : 1);
  }

  @Get(':userId/following')
  @ApiOperation({ summary: 'Get users that a user follows' })
  getFollowing(
    @Param('userId') userId: string,
    @Query('page') page?: string,
  ) {
    return this.followService.getFollowing(userId, page ? parseInt(page, 10) : 1);
  }
}
