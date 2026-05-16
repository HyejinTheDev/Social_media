import { Module } from '@nestjs/common';
import { ShortsController } from './shorts.controller';
import { ShortsService } from './shorts.service';
import { PrismaModule } from '../prisma/prisma.module';
import { NotificationsModule } from '../notifications/notifications.module';

@Module({
  imports: [PrismaModule, NotificationsModule],
  controllers: [ShortsController],
  providers: [ShortsService]
})
export class ShortsModule {}
