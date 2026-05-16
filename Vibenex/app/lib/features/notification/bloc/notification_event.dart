import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationEvent {}

class LoadMoreNotifications extends NotificationEvent {}

class MarkNotificationAsRead extends NotificationEvent {
  final String id;
  const MarkNotificationAsRead(this.id);
  
  @override
  List<Object?> get props => [id];
}

class MarkAllNotificationsAsRead extends NotificationEvent {}

class FetchUnreadCount extends NotificationEvent {}

class NotificationReceived extends NotificationEvent {
  final Map<String, dynamic> notification;
  const NotificationReceived(this.notification);

  @override
  List<Object?> get props => [notification];
}
