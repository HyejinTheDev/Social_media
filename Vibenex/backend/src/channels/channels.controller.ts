import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  UseGuards,
} from '@nestjs/common';
import { ChannelsService } from './channels.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('channels')
@UseGuards(JwtAuthGuard)
export class ChannelsController {
  constructor(private readonly channelsService: ChannelsService) {}

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.channelsService.findById(id);
  }
}
