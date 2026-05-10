import 'package:dio/dio.dart';

class NotificationApiService {
  final Dio _dio;

  NotificationApiService(this._dio);

  Future<Map<String, dynamic>> getNotifications(int page) async {
    final response = await _dio.get(
      '/notifications',
      queryParameters: {'page': page},
    );
    return response.data;
  }

  Future<int> getUnreadCount() async {
    final response = await _dio.get('/notifications/unread-count');
    return response.data['unreadCount'] ?? 0;
  }

  Future<void> markAsRead(String id) async {
    await _dio.patch('/notifications/$id/read');
  }

  Future<void> markAllAsRead() async {
    await _dio.patch('/notifications/read-all');
  }
}
