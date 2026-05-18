import {
  Controller, Get, Delete, Patch, Query, Param,
  UseGuards,
} from '@nestjs/common';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { AdminGuard } from './guards/admin.guard';
import { AdminService } from './admin.service';

@ApiTags('Admin')
@Controller('admin')
@UseGuards(JwtAuthGuard, AdminGuard)
@ApiBearerAuth()
export class AdminController {
  constructor(private adminService: AdminService) {}

  // ── Dashboard ──
  @Get('stats')
  @ApiOperation({ summary: 'Get dashboard statistics' })
  getStats() {
    return this.adminService.getStats();
  }

  // ── Users ──
  @Get('users')
  @ApiOperation({ summary: 'List all users' })
  @ApiQuery({ name: 'page', required: false })
  @ApiQuery({ name: 'search', required: false })
  getUsers(@Query('page') page?: string, @Query('search') search?: string) {
    return this.adminService.getUsers(Number(page) || 1, 20, search);
  }

  @Delete('users/:id')
  @ApiOperation({ summary: 'Delete a user' })
  deleteUser(@Param('id') id: string) {
    return this.adminService.deleteUser(id);
  }

  @Patch('users/:id/verify')
  @ApiOperation({ summary: 'Toggle user verified status' })
  toggleVerify(@Param('id') id: string) {
    return this.adminService.toggleVerify(id);
  }

  // ── Posts ──
  @Get('posts')
  @ApiOperation({ summary: 'List all posts' })
  @ApiQuery({ name: 'page', required: false })
  @ApiQuery({ name: 'search', required: false })
  getPosts(@Query('page') page?: string, @Query('search') search?: string) {
    return this.adminService.getPosts(Number(page) || 1, 20, search);
  }

  @Delete('posts/:id')
  @ApiOperation({ summary: 'Delete a post' })
  deletePost(@Param('id') id: string) {
    return this.adminService.deletePost(id);
  }

  // ── Shorts ──
  @Get('shorts')
  @ApiOperation({ summary: 'List all shorts' })
  @ApiQuery({ name: 'page', required: false })
  getShorts(@Query('page') page?: string) {
    return this.adminService.getShorts(Number(page) || 1);
  }

  @Delete('shorts/:id')
  @ApiOperation({ summary: 'Delete a short' })
  deleteShort(@Param('id') id: string) {
    return this.adminService.deleteShort(id);
  }

  // ── Communities ──
  @Get('communities')
  @ApiOperation({ summary: 'List all communities' })
  @ApiQuery({ name: 'page', required: false })
  @ApiQuery({ name: 'search', required: false })
  getCommunities(@Query('page') page?: string, @Query('search') search?: string) {
    return this.adminService.getCommunities(Number(page) || 1, 20, search);
  }

  @Delete('communities/:id')
  @ApiOperation({ summary: 'Delete a community' })
  deleteCommunity(@Param('id') id: string) {
    return this.adminService.deleteCommunity(id);
  }
}
