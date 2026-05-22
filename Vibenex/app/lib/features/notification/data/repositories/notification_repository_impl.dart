import '../../domain/models/notification_model.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_api_service.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApiService _api;

  NotificationRepositoryImpl(this._api);

  @override
  Future<NotificationListResult> getNotifications(int page) async {
    final data = await _api.getNotifications(page);
    final list = (data['notifications'] as List<dynamic>)
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final totalPages = data['totalPages'] as int;

    return NotificationListResult(
      notifications: list,
      totalPages: totalPages,
    );
  }

  @override
  Future<int> getUnreadCount() async {
    return _api.getUnreadCount();
  }

  @override
  Future<void> markAsRead(String id) async {
    await _api.markAsRead(id);
  }

  @override
  Future<void> markAllAsRead() async {
    await _api.markAllAsRead();
  }
}
