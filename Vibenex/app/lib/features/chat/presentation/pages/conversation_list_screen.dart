import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../bloc/chat_bloc.dart';

class ConversationListScreen extends StatefulWidget {
  const ConversationListScreen({super.key});

  @override
  State<ConversationListScreen> createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(const ChatLoadConversations());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text('Tin nhắn', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: cs.surface,
        elevation: 0,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state.conversationsStatus == ChatStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.conversationsStatus == ChatStatus.error) {
            return Center(child: Text(state.errorMessage ?? 'Lỗi'));
          }

          if (state.conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 64, color: cs.outlineVariant),
                  const SizedBox(height: 16),
                  Text('Chưa có cuộc trò chuyện nào', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Tìm bạn bè và bắt đầu trò chuyện', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ChatBloc>().add(const ChatLoadConversations());
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: state.conversations.length,
              itemBuilder: (context, index) {
                final conv = state.conversations[index] as Map<String, dynamic>;
                return _ConversationTile(conversation: conv);
              },
            ),
          );
        },
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final Map<String, dynamic> conversation;
  const _ConversationTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final other = conversation['otherUser'] as Map<String, dynamic>?;
    if (other == null) return const SizedBox.shrink();

    final avatarUrl = other['avatar'] != null ? '${AppConstants.baseUrl}${other['avatar']}' : null;
    final lastMessage = conversation['lastMessage'] as String? ?? '';
    final lastMessageAt = conversation['lastMessageAt'] as String?;

    return ListTile(
      leading: AvatarWidget(imageUrl: avatarUrl, radius: 28),
      title: Row(
        children: [
          Flexible(
            child: Text(
              other['name'] ?? '',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          if (other['isVerified'] == true) ...[
            const SizedBox(width: 4),
            Icon(Icons.verified, size: 16, color: cs.primary),
          ],
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
            ),
          ),
          if (lastMessageAt != null) ...[
            const SizedBox(width: 8),
            Text(
              timeago.format(DateTime.parse(lastMessageAt), locale: 'vi'),
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 11),
            ),
          ],
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      onTap: () {
        context.push('/chat/${conversation['id']}', extra: other);
      },
    );
  }
}
