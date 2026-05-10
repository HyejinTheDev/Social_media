import { Controller, Get, Patch, Param, Query, UseGuards, Request } from '@nestjs/common';
import { NotificationsService } from './notifications.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';

@ApiTags('Notifications')
@Controller('notifications')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class NotificationsController {
  constructor(private readonly notificationsService: NotificationsService) {}

  @Get()
  @ApiOperation({ summary: 'Get paginated notifications' })
  getNotifications(@Request() req: any, @Query('page') page?: string) {
    return this.notificationsService.getNotifications(req.user.sub, page ? parseInt(page, 10) : 1);
  }

  @Get('unread-count')
  @ApiOperation({ summary: 'Get unread notifications count' })
  getUnreadCount(@Request() req: any) {
    return this.notificationsService.getUnreadCount(req.user.sub);
  }

  @Patch('read-all')
  @ApiOperation({ summary: 'Mark all notifications as read' })
  markAllAsRead(@Request() req: any) {
    return this.notificationsService.markAllAsRead(req.user.sub);
  }

  @Patch(':id/read')
  @ApiOperation({ summary: 'Mark a specific notification as read' })
  markAsRead(@Request() req: any, @Param('id') id: string) {
    return this.notificationsService.markAsRead(id, req.user.sub);
  }
}
