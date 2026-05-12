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
import { CommunitiesService } from './communities.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('communities')
@UseGuards(JwtAuthGuard)
export class CommunitiesController {
  constructor(private readonly communitiesService: CommunitiesService) {}

  @Get()
  findAll(
    @Query('page') page = '1',
    @Query('limit') limit = '20',
    @Query('search') search?: string,
  ) {
    return this.communitiesService.findAll(
      parseInt(page),
      parseInt(limit),
      search,
    );
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.communitiesService.findById(id);
  }

  @Post()
  create(
    @Request() req,
    @Body() body: { name: string; description?: string; isPublic?: boolean },
  ) {
    return this.communitiesService.create(req.user.sub, body);
  }

  @Get(':communityId/channels')
  getChannels(@Param('communityId') communityId: string) {
    return this.communitiesService.getChannels(communityId);
  }

  @Post(':communityId/join')
  join(@Request() req, @Param('communityId') communityId: string) {
    return this.communitiesService.join(communityId, req.user.sub);
  }
}
