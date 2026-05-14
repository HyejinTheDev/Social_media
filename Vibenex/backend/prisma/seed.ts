import * as dotenv from 'dotenv';
import { PrismaClient, CommunityRole, ChannelType, NotificationType } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import * as bcrypt from 'bcrypt';
import * as path from 'path';

dotenv.config({ path: path.join(__dirname, '../.env') });
if (!process.env.DATABASE_URL) {
  process.env.DATABASE_URL = 'postgresql://postgres:postgres123@localhost:5434/vibenex?schema=public';
}

const connectionString = process.env.DATABASE_URL;
const adapter = new PrismaPg({ connectionString });
const prisma = new PrismaClient({ adapter });

async function main() {
  console.log('Seeding data...');

  // Clean existing data
  await prisma.notification.deleteMany();
  await prisma.message.deleteMany();
  await prisma.conversation.deleteMany();
  await prisma.reaction.deleteMany();
  await prisma.reply.deleteMany();
  await prisma.discussion.deleteMany();
  await prisma.channel.deleteMany();
  await prisma.communityMember.deleteMany();
  await prisma.community.deleteMany();
  await prisma.friendRequest.deleteMany();
  await prisma.comment.deleteMany();
  await prisma.postLike.deleteMany();
  await prisma.post.deleteMany();
  await prisma.user.deleteMany();

  // Create Users
  const passwordHash = await bcrypt.hash('password123', 10);
  
  const user1 = await prisma.user.create({
    data: {
      email: 'alice@example.com',
      username: 'alice_dev',
      name: 'Alice Nguyen',
      password: passwordHash,
      bio: 'Mobile Developer & UI Enthusiast',
      avatar: 'https://i.pravatar.cc/150?u=alice',
      reputation: 1500,
      isVerified: true,
    },
  });

  const user2 = await prisma.user.create({
    data: {
      email: 'bob@example.com',
      username: 'bob_designer',
      name: 'Bob Tran',
      password: passwordHash,
      bio: 'Product Designer',
      avatar: 'https://i.pravatar.cc/150?u=bob',
      reputation: 900,
    },
  });

  const user3 = await prisma.user.create({
    data: {
      email: 'hyejin@example.com',
      username: 'hyejin',
      name: 'Hyejin',
      password: passwordHash,
      bio: 'Fullstack Engineer | Creator of Vibenex',
      avatar: 'https://i.pravatar.cc/150?u=hyejin',
      coverPhoto: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=2564&auto=format&fit=crop',
      reputation: 5000,
      isVerified: true,
    },
  });

  console.log('Created users');

  // Create Communities
  const community1 = await prisma.community.create({
    data: {
      name: 'Flutter Vietnam',
      slug: 'flutter-vn',
      description: 'Cộng đồng lập trình viên Flutter tại Việt Nam. Nơi chia sẻ kiến thức, kinh nghiệm và tìm kiếm cơ hội việc làm.',
      icon: 'https://images.unsplash.com/photo-1617042375876-a13e36732a04?w=500&q=80',
      banner: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?q=80&w=2070&auto=format&fit=crop',
      memberCount: 3,
      channels: {
        create: [
          { name: 'general', type: ChannelType.TEXT, description: 'Chitchat và trao đổi chung' },
          { name: 'showcase', type: ChannelType.SHOWCASE, description: 'Khoe project của bạn' },
          { name: 'announcements', type: ChannelType.ANNOUNCEMENT, description: 'Thông báo từ ban quản trị' },
        ],
      },
    },
    include: { channels: true },
  });

  const community2 = await prisma.community.create({
    data: {
      name: 'UI/UX Designers',
      slug: 'ui-ux-design',
      description: 'Nơi hội tụ của những tâm hồn yêu cái đẹp. Chia sẻ tips, resources và feedback.',
      icon: 'https://images.unsplash.com/photo-1561070791-2526d30994b5?q=80&w=2000&auto=format&fit=crop',
      banner: 'https://images.unsplash.com/photo-1558655146-d09347e92766?q=80&w=2000&auto=format&fit=crop',
      memberCount: 2,
      channels: {
        create: [
          { name: 'general', type: ChannelType.TEXT },
          { name: 'feedback', type: ChannelType.TEXT, description: 'Nhờ vả feedback thiết kế' },
        ],
      },
    },
    include: { channels: true },
  });

  console.log('Created communities');

  // Add members
  await prisma.communityMember.createMany({
    data: [
      { communityId: community1.id, userId: user3.id, role: CommunityRole.OWNER },
      { communityId: community1.id, userId: user1.id, role: CommunityRole.ADMIN },
      { communityId: community1.id, userId: user2.id, role: CommunityRole.MEMBER },
      { communityId: community2.id, userId: user2.id, role: CommunityRole.OWNER },
      { communityId: community2.id, userId: user3.id, role: CommunityRole.MEMBER },
    ]
  });

  // Create Discussions
  const discussion1 = await prisma.discussion.create({
    data: {
      channelId: community1.channels.find(c => c.name === 'general')!.id,
      authorId: user3.id,
      content: 'Chào mừng mọi người đến với Vibenex phiên bản mới! 🚀\n\nChúng ta vừa áp dụng Stitch Design System với phong cách "Deep Space" cực xịn.',
      isPinned: true,
      replyCount: 1,
      reactionCount: 2,
      replies: {
        create: [
          {
            authorId: user1.id,
            content: 'Giao diện nhìn mượt quá sếp ơi!',
          }
        ]
      }
    }
  });

  const discussion2 = await prisma.discussion.create({
    data: {
      channelId: community1.channels.find(c => c.name === 'showcase')!.id,
      authorId: user1.id,
      content: 'Mình vừa release package mới hỗ trợ tạo animation siêu dễ trên Flutter. Mọi người dùng thử nhé: https://pub.dev/packages/flutter_animate',
      linkUrl: 'https://pub.dev/packages/flutter_animate',
      replyCount: 0,
      reactionCount: 1,
    }
  });

  console.log('Created discussions');

  // Create Reactions
  await prisma.reaction.createMany({
    data: [
      { emoji: '🔥', userId: user1.id, discussionId: discussion1.id },
      { emoji: '❤️', userId: user2.id, discussionId: discussion1.id },
      { emoji: '🚀', userId: user3.id, discussionId: discussion2.id },
    ]
  });

  // Create Conversations & Messages
  const conversation = await prisma.conversation.create({
    data: {
      participant1Id: user3.id,
      participant2Id: user1.id,
      lastMessage: 'Ok bạn, để mình check lại API.',
      lastMessageAt: new Date(),
      messages: {
        create: [
          { senderId: user1.id, content: 'Hi Hyejin, bạn xem giúp mình phần Auth API có lỗi kết nối không nhé.' },
          { senderId: user3.id, content: 'Ok bạn, để mình check lại API.', isRead: true },
        ]
      }
    }
  });

  console.log('Created chats');

  // Create Notifications
  await prisma.notification.createMany({
    data: [
      {
        userId: user3.id,
        type: NotificationType.LIKE,
        title: 'Lượt thích mới',
        body: 'Alice Nguyen đã thích bài đăng của bạn trong general.',
        isRead: false,
      },
      {
        userId: user3.id,
        type: NotificationType.COMMENT,
        title: 'Bình luận mới',
        body: 'Alice Nguyen đã trả lời bài đăng của bạn.',
        isRead: true,
      },
      {
        userId: user3.id,
        type: NotificationType.FOLLOW,
        title: 'Người theo dõi mới',
        body: 'Bob Tran vừa bắt đầu theo dõi bạn.',
        isRead: false,
      }
    ]
  });

  console.log('Created notifications');

  // Create Posts
  const post1 = await prisma.post.create({
    data: {
      authorId: user3.id,
      content: 'Chào buổi sáng mọi người! Hôm nay thời tiết thật đẹp 🌞. Mình chuẩn bị đi uống cà phê và làm việc đây.',
      likeCount: 2,
      commentCount: 1,
      likes: {
        create: [
          { userId: user1.id },
          { userId: user2.id }
        ]
      },
      comments: {
        create: [
          { authorId: user1.id, content: 'Chào chị nha, đi cafe vui vẻ!' }
        ]
      }
    }
  });

  const post2 = await prisma.post.create({
    data: {
      authorId: user1.id,
      content: 'Vừa học xong khóa học UI/UX design. Cảm thấy rất hào hứng để áp dụng vào project sắp tới! 🎨✨',
      imageUrls: ['https://images.unsplash.com/photo-1561070791-2526d30994b5?q=80&w=2000&auto=format&fit=crop'],
      likeCount: 1,
      likes: {
        create: [{ userId: user3.id }]
      }
    }
  });

  const post3 = await prisma.post.create({
    data: {
      authorId: user2.id,
      content: 'Mọi người có recommend cuốn sách nào về thiết kế không ạ?',
      likeCount: 0,
      commentCount: 2,
      comments: {
        create: [
          { authorId: user1.id, content: "Đọc cuốn 'Don't Make Me Think' nha bạn." },
          { authorId: user3.id, content: "Cuốn 'The Design of Everyday Things' cũng rất hay nè." }
        ]
      }
    }
  });

  console.log('Created posts');

  // Create FriendRequests (Friendships)
  await prisma.friendRequest.createMany({
    data: [
      { senderId: user1.id, receiverId: user3.id, status: 'ACCEPTED' },
      { senderId: user2.id, receiverId: user3.id, status: 'PENDING' },
    ]
  });

  console.log('Created friends');
  console.log('Seed completed successfully!');
  console.log('\\n--- Test Accounts ---');
  console.log('1. hyejin@example.com / password123');
  console.log('2. alice@example.com / password123');
  console.log('3. bob@example.com / password123');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
