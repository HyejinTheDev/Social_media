import '../models/notification_model.dart';

abstract class NotificationRepository {
  Future<NotificationListResult> getNotifications(int page);
  Future<int> getUnreadCount();
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
}

class NotificationListResult {
  final List<NotificationModel> notifications;
  final int totalPages;

  NotificationListResult({
    required this.notifications,
    required this.totalPages,
  });
}
