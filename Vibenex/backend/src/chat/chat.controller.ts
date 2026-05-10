import {
  Controller, Get, Post, Delete, Param, Query, Body,
  UseGuards, Request,
} from '@nestjs/common';
import { ChatService } from './chat.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';

@ApiTags('Chat')
@Controller('chat')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @Get('conversations')
  @ApiOperation({ summary: 'Get all conversations' })
  getConversations(@Request() req: any) {
    return this.chatService.getConversations(req.user.sub);
  }

  @Post('conversations/:userId')
  @ApiOperation({ summary: 'Get or create conversation with a user' })
  getOrCreateConversation(
    @Request() req: any,
    @Param('userId') userId: string,
  ) {
    return this.chatService.getOrCreateConversation(req.user.sub, userId);
  }

  @Get('conversations/:conversationId/messages')
  @ApiOperation({ summary: 'Get messages in a conversation' })
  getMessages(
    @Request() req: any,
    @Param('conversationId') conversationId: string,
    @Query('page') page?: string,
  ) {
    return this.chatService.getMessages(
      conversationId,
      req.user.sub,
      page ? parseInt(page, 10) : 1,
    );
  }

  @Post('conversations/:conversationId/messages')
  @ApiOperation({ summary: 'Send a message (REST fallback)' })
  sendMessage(
    @Request() req: any,
    @Param('conversationId') conversationId: string,
    @Body() body: { content: string; imageUrl?: string },
  ) {
    return this.chatService.sendMessage(
      conversationId,
      req.user.sub,
      body.content,
      body.imageUrl,
    );
  }

  @Post('conversations/:conversationId/read')
  @ApiOperation({ summary: 'Mark messages as read' })
  markAsRead(
    @Request() req: any,
    @Param('conversationId') conversationId: string,
  ) {
    return this.chatService.markAsRead(conversationId, req.user.sub);
  }

  @Get('conversations/:conversationId/unread')
  @ApiOperation({ summary: 'Get unread count' })
  getUnreadCount(
    @Request() req: any,
    @Param('conversationId') conversationId: string,
  ) {
    return this.chatService.getUnreadCount(conversationId, req.user.sub);
  }

  @Delete('messages/:messageId')
  @ApiOperation({ summary: 'Delete a message' })
  deleteMessage(@Request() req: any, @Param('messageId') messageId: string) {
    return this.chatService.deleteMessage(messageId, req.user.sub);
  }
}
