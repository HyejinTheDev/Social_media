import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { ChatModule } from './chat/chat.module';
import { NotificationsModule } from './notifications/notifications.module';
import { CommunitiesModule } from './communities/communities.module';
import { ReactionsModule } from './reactions/reactions.module';
import { RepliesModule } from './replies/replies.module';
import { DiscussionsModule } from './discussions/discussions.module';
import { ChannelsModule } from './channels/channels.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    PrismaModule,
    AuthModule,
    UsersModule,
    ChatModule,
    NotificationsModule,
    CommunitiesModule,
    ChannelsModule,
    DiscussionsModule,
    RepliesModule,
    ReactionsModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
