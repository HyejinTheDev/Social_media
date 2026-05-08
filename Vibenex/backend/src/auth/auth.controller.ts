import { Controller, Post, Body, Get, UseGuards, Request, Param } from '@nestjs/common';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { RegisterDto, LoginDto, RefreshTokenDto, ForgotPasswordDto } from './dto/auth.dto';
import { JwtAuthGuard } from './guards/jwt-auth.guard';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('register')
  @ApiOperation({ summary: 'Register a new account' })
  register(@Body() dto: RegisterDto) {
    return this.authService.register(dto);
  }

  @Post('login')
  @ApiOperation({ summary: 'Login with email and password' })
  login(@Body() dto: LoginDto) {
    return this.authService.login(dto);
  }

  @Post('refresh')
  @ApiOperation({ summary: 'Refresh access token' })
  refresh(@Body() dto: RefreshTokenDto) {
    return this.authService.refreshToken(dto.refreshToken);
  }

  @Post('forgot-password')
  @ApiOperation({ summary: 'Send password reset link' })
  forgotPassword(@Body() dto: ForgotPasswordDto) {
    // Mock — just return success
    return { message: 'Đã gửi liên kết đặt lại mật khẩu vào email' };
  }

  @Get('check-username/:username')
  @ApiOperation({ summary: 'Check if username is available' })
  async checkUsername(@Param('username') username: string) {
    const exists = await this.authService.checkUsername(username);
    return { available: !exists };
  }

  @Get('me')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Get current user profile' })
  getProfile(@Request() req: any) {
    return this.authService.getProfile(req.user.sub);
  }
}
