# Vibenex - Nền tảng Mạng Xã Hội Hiện Đại 🚀

**Vibenex** là một ứng dụng mạng xã hội hoàn chỉnh (Fullstack) hỗ trợ chia sẻ hình ảnh, video ngắn, trò chuyện thời gian thực và quản lý tài khoản với giao diện mượt mà, chuyên nghiệp.

![Vibenex UI](https://via.placeholder.com/800x400?text=Vibenex+Social+Media)

## 🌟 Tính Năng Nổi Bật

* **Xác thực & Bảo mật (Authentication)**: Đăng ký/Đăng nhập an toàn với JWT, mã hóa mật khẩu bcrypt, hỗ trợ phiên đăng nhập tự động.
* **Bảng tin (Feed)**: Cuộn mượt mà vô hạn (Infinite Scroll), hiển thị bài viết, hình ảnh, video với hiệu ứng nhấp đúp thả tim (Double-tap to like).
* **Trò chuyện trực tuyến (Realtime Chat)**: Nhắn tin tức thời sử dụng **Socket.IO**. Hiển thị trạng thái "Đang nhập..." (Typing indicator) và dấu tích đã đọc.
* **Tin tin vắn (Stories)**: Đăng và xem Story tự động chuyển trang (tương tự Instagram).
* **Quản lý Hồ sơ (Profile)**: Cập nhật thông tin cá nhân, ảnh đại diện, ảnh bìa, lưới bài viết cá nhân. Chức năng Theo dõi (Follow) và thống kê người theo dõi.
* **Thông báo (Notifications)**: Thông báo realtime khi có người Like, Comment, hoặc Follow.
* **Tối ưu trải nghiệm (UX Polish)**:
  * Animation chuyển trang mượt mà (Custom Page Transitions).
  * Hiệu ứng rung (Haptic Feedback) khi thực hiện tác vụ chính.
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

### Backend (Máy chủ API)
* **Framework**: NestJS (TypeScript)
* **Cơ sở dữ liệu (Database)**: PostgreSQL (Chạy trên Docker)
* **ORM**: Prisma
* **Realtime**: Socket.IO
* **Bảo mật**: JWT (Passport), Bcrypt, Throttler (Rate Limiting).

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

# Khởi động server
npm run start:dev
```
Backend sẽ chạy tại: `http://localhost:3000`. Cổng Swagger UI: `http://localhost:3000/api`.

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
# và thay đổi `baseUrl` trỏ về IP máy tính của bạn (VD: http://192.168.1.x:3000) thay vì localhost nếu chạy trên thiết bị vật lý.

# Khởi chạy ứng dụng
flutter run
```

## 🏗 Kiến Trúc Ứng Dụng (Architecture)

Ứng dụng Flutter được chia thành các thư mục rõ ràng theo hướng Feature-first kết hợp Clean Architecture:
* `lib/core/`: Chứa các tiện ích, constants, routing, dependency injection (GetIt), và các UI Widgets dùng chung (CustomButton, ShimmerLoading, EmptyState...).
* `lib/features/`: Phân chia theo từng tính năng (auth, post, profile, chat, notification...). Trong mỗi feature sẽ có:
  * `domain/`: Abstract classes, UseCases, Models (Freezed).
  * `data/`: ApiService (Retrofit), Repositories Implementation.
  * `bloc/`: Quản lý trạng thái với BLoC/Cubit.
  * `presentation/`: Pages và Widgets riêng biệt của tính năng đó.

## 🤝 Tác Giả
* **Hyejin The Dev** (Hoàn thiện tháng 5/2026).
