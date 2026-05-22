# Vibenex - Nền tảng Mạng Xã Hội Hiện Đại 🚀

**Vibenex** là một ứng dụng mạng xã hội hoàn chỉnh (Fullstack) hỗ trợ chia sẻ hình ảnh, video ngắn (Shorts), cộng đồng (Communities), trò chuyện thời gian thực và quản lý tài khoản với giao diện mượt mà, chuyên nghiệp.

## 🌟 Tính Năng Nổi Bật

* **Xác thực & Bảo mật (Authentication)**: Đăng ký/Đăng nhập an toàn với JWT, mã hóa mật khẩu bcrypt, token tự động refresh.
* **Bảng tin (Feed)**: Cuộn mượt mà vô hạn (Infinite Scroll), hiển thị bài viết, hình ảnh, video với hiệu ứng nhấp đúp thả tim (Double-tap to like).
* **Tin ngắn (Stories)**: Đăng và xem Story 24h tự động hết hạn (tương tự Instagram), theo dõi lượt xem.
* **Video ngắn (Shorts)**: Quay và đăng video ngắn dạng TikTok, like, bình luận.
* **Cộng đồng (Communities)**: Tạo và tham gia cộng đồng, channels (Text, Announcement, Live Chat, Voice Room), discussions với emoji reactions.
* **Trò chuyện trực tuyến (Realtime Chat)**: Nhắn tin tức thời sử dụng **Socket.IO**. Hiển thị trạng thái "Đang nhập..." và dấu tích đã đọc.
* **Kết bạn (Friends)**: Gửi/nhận lời mời kết bạn, chấp nhận/từ chối, danh sách bạn bè.
* **Quản lý Hồ sơ (Profile)**: Cập nhật thông tin cá nhân, ảnh đại diện, ảnh bìa.
* **Thông báo (Notifications)**: Thông báo realtime khi có người Like, Comment, hoặc gửi lời mời kết bạn.
* **Admin Dashboard**: Quản trị hệ thống — thống kê, quản lý user/post/short/community.
* **Tối ưu trải nghiệm (UX Polish)**:
  * Animation chuyển trang mượt mà (Custom Page Transitions).
  * Hỗ trợ giao diện Sáng/Tối (Dark Mode) và Đa ngôn ngữ (Tiếng Việt/English).
  * Cảnh báo trạng thái ngoại tuyến (Offline Banner) tự động.

## 🛠 Công Nghệ Sử Dụng

### Frontend (Ứng dụng Di động)
* **Framework**: Flutter (Dart)
* **Quản lý trạng thái (State Management)**: BLoC (Business Logic Component) / flutter_bloc
* **Kiến trúc**: Clean Architecture (Domain - Data - Presentation)
* **Networking**: Dio & Retrofit
* **Routing**: GoRouter
* **Local Storage**: SharedPreferences & Flutter Secure Storage
* **Giao diện (UI)**: Material 3, Shimmer loading, Lottie animations, Cached Network Image.
* **Realtime**: socket_io_client

### Backend (Máy chủ API)
* **Framework**: NestJS (TypeScript)
* **Cơ sở dữ liệu (Database)**: PostgreSQL (Chạy trên Docker)
* **ORM**: Prisma
* **Realtime**: Socket.IO (WebSocket Gateway)
* **Bảo mật**: JWT (Passport), Bcrypt.
* **Upload**: Multer (local) + Cloudinary (cloud)
* **API Docs**: Swagger

---

## ⚙️ Hướng Dẫn Cài Đặt (Getting Started)

### 1. Cài đặt Backend (NestJS)
Yêu cầu: Đã cài đặt `Node.js` (>= 18), `npm` và `Docker`.

```bash
cd backend

# Cài đặt thư viện
npm install

# Khởi động PostgreSQL qua Docker Compose
docker-compose up -d

# Cấu hình biến môi trường
cp .env.example .env
# (Chỉnh sửa DATABASE_URL và JWT_SECRET trong .env nếu cần)

# Chạy migration để tạo bảng
npx prisma migrate dev

# Seed dữ liệu mẫu (tuỳ chọn)
npx prisma db seed

# Khởi động server
npm run start:dev
```
Backend sẽ chạy tại: `http://localhost:3001`. Swagger UI: `http://localhost:3001/api`.

### 2. Cài đặt Frontend (Flutter)
Yêu cầu: Đã cài đặt `Flutter SDK` (>= 3.2.0).

```bash
cd app

# Lấy các packages
flutter pub get

# Sinh code tự động (Cho Retrofit, Freezed, Bloc, v.v.)
dart run build_runner build --delete-conflicting-outputs

# Cấu hình địa chỉ IP Backend
# Lưu ý: Mở file `lib/core/constants/app_constants.dart` 
# và thay đổi `baseUrl` trỏ về IP máy tính của bạn (VD: http://192.168.1.x:3001)

# Khởi chạy ứng dụng
flutter run
```

## 🏗 Kiến Trúc Ứng Dụng (Architecture)

Ứng dụng Flutter được chia thành các thư mục rõ ràng theo hướng Feature-first kết hợp Clean Architecture:
* `lib/core/`: Chứa các tiện ích, constants, routing, dependency injection (GetIt), theme, i18n, và các UI Widgets dùng chung.
* `lib/features/`: Phân chia theo từng tính năng (auth, home, profile, chat, notification, community, discussion, explore, shorts, settings, admin...). Trong mỗi feature sẽ có:
  * `domain/`: Abstract repositories, Models.
  * `data/`: ApiService (Retrofit/Dio), Repositories Implementation.
  * `bloc/`: Quản lý trạng thái với BLoC/Cubit.
  * `presentation/`: Pages và Widgets riêng biệt của tính năng đó.

### Backend Architecture
```
backend/src/
├── auth/           # JWT auth, login, register, refresh, change-password
├── users/          # Profile CRUD, search, avatar/cover upload
├── posts/          # Create/delete/list posts, like/unlike, comments
├── stories/        # Create/list/delete stories, mark viewed, upload
├── friends/        # Send/accept/reject friend request, list friends
├── chat/           # WebSocket gateway, conversations, messages, voice rooms
├── notifications/  # CRUD notifications, realtime push
├── communities/    # CRUD communities, channels, join/leave
├── discussions/    # CRUD discussions in channels
├── replies/        # Nested replies for discussions
├── reactions/      # Emoji reactions on discussions/replies
├── shorts/         # Short videos - CRUD, like, comments
├── channels/       # Channel management
├── admin/          # Dashboard stats, user/post/short/community management
├── cloudinary/     # Cloud image/video upload
├── common/         # Guards, decorators
└── prisma/         # PrismaService
```

## 🤝 Tác Giả
* **Hyejin The Dev** (Hoàn thiện tháng 5/2026).
