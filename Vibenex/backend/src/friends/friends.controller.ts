import {
  Controller,
  Get,
  Post,
  Delete,
  Param,
  UseGuards,
  Request,
} from '@nestjs/common';
import { FriendsService } from './friends.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('friends')
@UseGuards(JwtAuthGuard)
export class FriendsController {
  constructor(private readonly friendsService: FriendsService) {}

  @Post('request/:userId')
  sendRequest(@Request() req, @Param('userId') receiverId: string) {
    return this.friendsService.sendRequest(req.user.sub, receiverId);
  }

  @Post('accept/:requestId')
  acceptRequest(@Request() req, @Param('requestId') requestId: string) {
    return this.friendsService.acceptRequest(requestId, req.user.sub);
  }

  @Post('reject/:requestId')
  rejectRequest(@Request() req, @Param('requestId') requestId: string) {
    return this.friendsService.rejectRequest(requestId, req.user.sub);
  }

  @Delete(':userId')
  removeFriend(@Request() req, @Param('userId') friendId: string) {
    return this.friendsService.removeFriend(req.user.sub, friendId);
  }

  @Get()
  getFriends(@Request() req) {
    return this.friendsService.getFriends(req.user.sub);
  }

  @Get('requests')
  getPendingRequests(@Request() req) {
    return this.friendsService.getPendingRequests(req.user.sub);
  }
}
