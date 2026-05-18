import { Module } from '@nestjs/common';
import { ShortsController } from './shorts.controller';
import { ShortsService } from './shorts.service';
import { PrismaModule } from '../prisma/prisma.module';
import { NotificationsModule } from '../notifications/notifications.module';
import { CloudinaryModule } from '../cloudinary/cloudinary.module';

@Module({
  imports: [PrismaModule, NotificationsModule, CloudinaryModule],
  controllers: [ShortsController],
  providers: [ShortsService]
})
export class ShortsModule {}
