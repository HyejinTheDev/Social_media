import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;
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
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text('Thông báo', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: cs.surface,
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
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == NotificationStatus.error && state.notifications.isEmpty) {
            return Center(child: Text(state.errorMessage ?? 'Có lỗi xảy ra'));
          }

          if (state.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 64, color: cs.outlineVariant),
                  const SizedBox(height: 16),
                  Text('Bạn chưa có thông báo nào', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 16)),
                ],
              ),
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
                    child: Center(child: CircularProgressIndicator()),
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
    final cs = Theme.of(context).colorScheme;
    final isRead = item['isRead'] == true;
    final type = item['type'] as String;

    IconData icon;
    Color iconColor;

    switch (type) {
      case 'LIKE':
        icon = Icons.favorite;
        iconColor = Colors.red;
        break;
      case 'COMMENT':
        icon = Icons.comment;
        iconColor = Colors.blue;
        break;
      case 'FOLLOW':
        icon = Icons.person_add;
        iconColor = Colors.green;
        break;
      default:
        icon = Icons.notifications;
        iconColor = cs.primary;
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
              context.push('/post/${data['postId']}');
            }
          } else if (type == 'FOLLOW') {
            if (data['followerId'] != null) {
              context.push('/profile/${data['followerId']}');
            }
          }
        }
      },
      child: Container(
        color: isRead ? Colors.transparent : cs.primaryContainer.withValues(alpha: 0.3),
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['body'] ?? '',
                    style: TextStyle(color: cs.onSurfaceVariant, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    timeago.format(DateTime.parse(item['createdAt']), locale: 'vi'),
                    style: TextStyle(color: cs.outline, fontSize: 12),
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
                  decoration: BoxDecoration(
                    color: cs.primary,
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
