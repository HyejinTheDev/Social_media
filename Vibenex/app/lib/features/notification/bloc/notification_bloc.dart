import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../../chat/data/datasources/socket_service.dart';
import '../domain/models/notification_model.dart';
import '../domain/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

export 'notification_event.dart';
export 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _repository;
  final SocketService _socket;
  StreamSubscription? _notificationSub;

  NotificationBloc({
    required NotificationRepository repository,
    required SocketService socket,
  })  : _repository = repository,
        _socket = socket,
        super(const NotificationState()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<LoadMoreNotifications>(_onLoadMoreNotifications);
    on<MarkNotificationAsRead>(_onMarkAsRead);
    on<MarkAllNotificationsAsRead>(_onMarkAllAsRead);
    on<FetchUnreadCount>(_onFetchUnreadCount);
    on<NotificationReceived>(_onNotificationReceived);

    _notificationSub = _socket.onNewNotification.listen((data) {
      add(NotificationReceived(data));
    });
  }

  @override
  Future<void> close() {
    _notificationSub?.cancel();
    return super.close();
  }

  Future<void> _onLoadNotifications(LoadNotifications event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    try {
      final unreadCount = await _repository.getUnreadCount();
      final result = await _repository.getNotifications(1);

      emit(state.copyWith(
        status: NotificationStatus.loaded,
        notifications: result.notifications,
        page: 1,
        hasMore: 1 < result.totalPages,
        unreadCount: unreadCount,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationStatus.error,
        errorMessage: ErrorMapper.map(e),
      ));
    }
  }

  Future<void> _onLoadMoreNotifications(LoadMoreNotifications event, Emitter<NotificationState> emit) async {
    if (!state.hasMore || state.status == NotificationStatus.loading) return;

    final nextPage = state.page + 1;
    try {
      final result = await _repository.getNotifications(nextPage);

      emit(state.copyWith(
        notifications: [...state.notifications, ...result.notifications],
        page: nextPage,
        hasMore: nextPage < result.totalPages,
      ));
    } catch (_) {}
  }

  Future<void> _onMarkAsRead(MarkNotificationAsRead event, Emitter<NotificationState> emit) async {
    try {
      // Optimistic UI update
      final updatedList = state.notifications.map((n) {
        if (n.id == event.id && !n.isRead) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();
      
      final unreadCount = updatedList.where((n) => !n.isRead).length;
      
      emit(state.copyWith(notifications: updatedList, unreadCount: unreadCount));
      
      await _repository.markAsRead(event.id);
    } catch (_) {}
  }

  Future<void> _onMarkAllAsRead(MarkAllNotificationsAsRead event, Emitter<NotificationState> emit) async {
    try {
      final updatedList = state.notifications.map((n) => n.copyWith(isRead: true)).toList();
      emit(state.copyWith(notifications: updatedList, unreadCount: 0));
      await _repository.markAllAsRead();
    } catch (_) {}
  }

  Future<void> _onFetchUnreadCount(FetchUnreadCount event, Emitter<NotificationState> emit) async {
    try {
      final count = await _repository.getUnreadCount();
      emit(state.copyWith(unreadCount: count));
    } catch (_) {}
  }

  Future<void> _onNotificationReceived(NotificationReceived event, Emitter<NotificationState> emit) async {
    final newNotification = NotificationModel.fromJson(event.notification);
    final updatedList = [newNotification, ...state.notifications];
    final unreadCount = state.unreadCount + 1;
    
    emit(state.copyWith(
      notifications: updatedList,
      unreadCount: unreadCount,
    ));
  }
}
