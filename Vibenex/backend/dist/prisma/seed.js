"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
const dotenv = __importStar(require("dotenv"));
const client_1 = require("@prisma/client");
const adapter_pg_1 = require("@prisma/adapter-pg");
const bcrypt = __importStar(require("bcrypt"));
const path = __importStar(require("path"));
dotenv.config({ path: path.join(__dirname, '../.env') });
if (!process.env.DATABASE_URL) {
    process.env.DATABASE_URL = 'postgresql://postgres:postgres123@localhost:5434/vibenex?schema=public';
}
const connectionString = process.env.DATABASE_URL;
const adapter = new adapter_pg_1.PrismaPg({ connectionString });
const prisma = new client_1.PrismaClient({ adapter });
async function main() {
    console.log('Seeding data...');
    await prisma.notification.deleteMany();
    await prisma.message.deleteMany();
    await prisma.conversation.deleteMany();
    await prisma.reaction.deleteMany();
    await prisma.reply.deleteMany();
    await prisma.discussion.deleteMany();
    await prisma.channel.deleteMany();
    await prisma.communityMember.deleteMany();
    await prisma.community.deleteMany();
    await prisma.user.deleteMany();
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
    const community1 = await prisma.community.create({
        data: {
            name: 'Flutter Vietnam',
            slug: 'flutter-vn',
            description: 'Cộng đồng lập trình viên Flutter tại Việt Nam. Nơi chia sẻ kiến thức, kinh nghiệm và tìm kiếm cơ hội việc làm.',
            icon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            banner: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?q=80&w=2070&auto=format&fit=crop',
            memberCount: 3,
            channels: {
                create: [
                    { name: 'general', type: client_1.ChannelType.TEXT, description: 'Chitchat và trao đổi chung' },
                    { name: 'showcase', type: client_1.ChannelType.SHOWCASE, description: 'Khoe project của bạn' },
                    { name: 'announcements', type: client_1.ChannelType.ANNOUNCEMENT, description: 'Thông báo từ ban quản trị' },
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
                    { name: 'general', type: client_1.ChannelType.TEXT },
                    { name: 'feedback', type: client_1.ChannelType.TEXT, description: 'Nhờ vả feedback thiết kế' },
                ],
            },
        },
        include: { channels: true },
    });
    console.log('Created communities');
    await prisma.communityMember.createMany({
        data: [
            { communityId: community1.id, userId: user3.id, role: client_1.CommunityRole.OWNER },
            { communityId: community1.id, userId: user1.id, role: client_1.CommunityRole.ADMIN },
            { communityId: community1.id, userId: user2.id, role: client_1.CommunityRole.MEMBER },
            { communityId: community2.id, userId: user2.id, role: client_1.CommunityRole.OWNER },
            { communityId: community2.id, userId: user3.id, role: client_1.CommunityRole.MEMBER },
        ]
    });
    const discussion1 = await prisma.discussion.create({
        data: {
            channelId: community1.channels.find(c => c.name === 'general').id,
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
            channelId: community1.channels.find(c => c.name === 'showcase').id,
            authorId: user1.id,
            content: 'Mình vừa release package mới hỗ trợ tạo animation siêu dễ trên Flutter. Mọi người dùng thử nhé: https://pub.dev/packages/flutter_animate',
            linkUrl: 'https://pub.dev/packages/flutter_animate',
            replyCount: 0,
            reactionCount: 1,
        }
    });
    console.log('Created discussions');
    await prisma.reaction.createMany({
        data: [
            { emoji: '🔥', userId: user1.id, discussionId: discussion1.id },
            { emoji: '❤️', userId: user2.id, discussionId: discussion1.id },
            { emoji: '🚀', userId: user3.id, discussionId: discussion2.id },
        ]
    });
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
    await prisma.notification.createMany({
        data: [
            {
                userId: user3.id,
                type: client_1.NotificationType.LIKE,
                title: 'Lượt thích mới',
                body: 'Alice Nguyen đã thích bài đăng của bạn trong general.',
                isRead: false,
            },
            {
                userId: user3.id,
                type: client_1.NotificationType.COMMENT,
                title: 'Bình luận mới',
                body: 'Alice Nguyen đã trả lời bài đăng của bạn.',
                isRead: true,
            },
            {
                userId: user3.id,
                type: client_1.NotificationType.FOLLOW,
                title: 'Người theo dõi mới',
                body: 'Bob Tran vừa bắt đầu theo dõi bạn.',
                isRead: false,
            }
        ]
    });
    console.log('Created notifications');
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
//# sourceMappingURL=seed.js.map