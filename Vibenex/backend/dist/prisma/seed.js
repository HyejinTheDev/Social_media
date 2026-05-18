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
    await prisma.friendRequest.deleteMany();
    await prisma.comment.deleteMany();
    await prisma.postLike.deleteMany();
    await prisma.post.deleteMany();
    await prisma.shortComment.deleteMany();
    await prisma.shortLike.deleteMany();
    await prisma.short.deleteMany();
    await prisma.story.deleteMany();
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
            role: 'ADMIN',
        },
    });
    console.log('Created users');
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
    await prisma.friendRequest.createMany({
        data: [
            { senderId: user1.id, receiverId: user3.id, status: 'ACCEPTED' },
            { senderId: user2.id, receiverId: user3.id, status: 'PENDING' },
        ]
    });
    console.log('Created friends');
    await prisma.short.createMany({
        data: [
            {
                authorId: user1.id,
                caption: 'Học code hiệu quả trong 1 phút 💻🚀',
                videoUrl: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
                thumbnailUrl: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?q=80&w=2070&auto=format&fit=crop',
                likeCount: 15,
                commentCount: 3,
                shareCount: 2,
            },
            {
                authorId: user2.id,
                caption: 'Review góc setup làm việc chill nhất ☕',
                videoUrl: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
                thumbnailUrl: 'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?q=80&w=2070&auto=format&fit=crop',
                likeCount: 42,
                commentCount: 5,
                shareCount: 10,
            },
            {
                authorId: user3.id,
                caption: 'Vlog đi chơi cuối tuần cùng bạn thân ✨',
                videoUrl: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
                thumbnailUrl: 'https://images.unsplash.com/photo-1511895426328-dc8714191300?q=80&w=2070&auto=format&fit=crop',
                likeCount: 8,
                commentCount: 1,
                shareCount: 0,
            }
        ]
    });
    console.log('Created shorts');
    const voiceRoom = await prisma.community.create({
        data: {
            name: 'Flutter Vietnam Chill ☕️',
            slug: 'flutter-vn-chill',
            description: 'Phòng voice chill cùng anh em Flutter',
            isPublic: true,
            isVoiceRoom: true,
            memberCount: 3,
            channels: { create: [{ name: 'voice-main', type: client_1.ChannelType.VOICE }] },
        },
    });
    const chatRoom = await prisma.community.create({
        data: {
            name: 'Review UI/UX tháng 5',
            slug: 'review-uiux-t5',
            description: 'Phòng chat review thiết kế',
            isPublic: true,
            isVoiceRoom: false,
            memberCount: 2,
            channels: { create: [{ name: 'chat-main', type: client_1.ChannelType.LIVE_CHAT }] },
        },
    });
    const gamingRoom = await prisma.community.create({
        data: {
            name: 'Gaming Night 🎮',
            slug: 'gaming-night',
            description: 'Phòng voice chơi game tối thứ 7',
            isPublic: true,
            isVoiceRoom: true,
            memberCount: 2,
            channels: { create: [{ name: 'voice-gaming', type: client_1.ChannelType.VOICE }] },
        },
    });
    await prisma.communityMember.createMany({
        data: [
            { communityId: voiceRoom.id, userId: user3.id, role: client_1.CommunityRole.OWNER },
            { communityId: voiceRoom.id, userId: user1.id, role: client_1.CommunityRole.MEMBER },
            { communityId: voiceRoom.id, userId: user2.id, role: client_1.CommunityRole.MEMBER },
            { communityId: chatRoom.id, userId: user2.id, role: client_1.CommunityRole.OWNER },
            { communityId: chatRoom.id, userId: user3.id, role: client_1.CommunityRole.MEMBER },
            { communityId: gamingRoom.id, userId: user1.id, role: client_1.CommunityRole.OWNER },
            { communityId: gamingRoom.id, userId: user3.id, role: client_1.CommunityRole.MEMBER },
        ],
    });
    console.log('Created voice & chat rooms');
    const now = new Date();
    const tomorrow = new Date(now.getTime() + 24 * 60 * 60 * 1000);
    await prisma.story.createMany({
        data: [
            {
                authorId: user3.id,
                imageUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=800',
                expiresAt: tomorrow,
            },
            {
                authorId: user1.id,
                imageUrl: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?q=80&w=800',
                expiresAt: tomorrow,
            },
            {
                authorId: user2.id,
                imageUrl: 'https://images.unsplash.com/photo-1558655146-d09347e92766?q=80&w=800',
                expiresAt: tomorrow,
            },
        ],
    });
    console.log('Created stories');
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