import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/notification_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(LoadNotifications());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<NotificationBloc>().add(LoadMoreNotifications());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Thông báo', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSilver)),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Đánh dấu tất cả đã đọc',
            onPressed: () {
              context.read<NotificationBloc>().add(MarkAllNotificationsAsRead());
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state.status == NotificationStatus.loading && state.notifications.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: AppColors.brandViolet));
          }

          if (state.status == NotificationStatus.error && state.notifications.isEmpty) {
            return ErrorStateWidget(
              message: state.errorMessage ?? 'Có lỗi xảy ra',
              onRetry: () => context.read<NotificationBloc>().add(LoadNotifications()),
            );
          }

          if (state.notifications.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.notifications_none,
              title: 'Chưa có thông báo nào',
              subtitle: 'Khi có người tương tác với bạn, thông báo sẽ hiển thị ở đây.',
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<NotificationBloc>().add(LoadNotifications());
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.notifications.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.notifications.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator(color: AppColors.brandViolet)),
                  );
                }

                final item = state.notifications[index] as Map<String, dynamic>;
                return _NotificationTile(item: item);
              },
            ),
          );
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final Map<String, dynamic> item;

  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final isRead = item['isRead'] == true;
    final type = item['type'] as String;

    IconData icon;
    Color iconColor;

    switch (type) {
      case 'LIKE':
        icon = Icons.favorite;
        iconColor = AppColors.hotPink;
        break;
      case 'COMMENT':
        icon = Icons.comment;
        iconColor = AppColors.electricIndigo;
        break;
      case 'FOLLOW':
        icon = Icons.person_add;
        iconColor = AppColors.brandViolet;
        break;
      default:
        icon = Icons.notifications;
        iconColor = AppColors.textFog;
    }

    return InkWell(
      onTap: () {
        if (!isRead) {
          context.read<NotificationBloc>().add(MarkNotificationAsRead(item['id']));
        }

        // Navigate based on type
        final data = item['data'] as Map<String, dynamic>?;
        if (data != null) {
          if (type == 'LIKE' || type == 'COMMENT') {
            if (data['postId'] != null) {
              context.go('/home');
            }
          } else if (type == 'FOLLOW') {
            if (data['followerId'] != null) {
              context.push('/profile/${data['followerId']}');
            }
          }
        }
      },
      child: Container(
        color: isRead ? Colors.transparent : AppColors.surfaceContainer,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textSilver),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['body'] ?? '',
                    style: const TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    timeago.format(DateTime.parse(item['createdAt']), locale: 'vi'),
                    style: const TextStyle(color: AppColors.textFog, fontSize: 12),
                  ),
                ],
              ),
            ),
            if (!isRead)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.brandViolet,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
