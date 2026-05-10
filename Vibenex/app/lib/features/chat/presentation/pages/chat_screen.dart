import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../bloc/chat_bloc.dart';
import '../../data/datasources/socket_service.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final Map<String, dynamic>? otherUser;

  const ChatScreen({
    super.key,
    required this.conversationId,
    this.otherUser,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isOtherTyping = false;
  StreamSubscription? _typingSub;

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(ChatOpenConversation(widget.conversationId));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    context.read<ChatBloc>().add(const ChatLeaveConversation());
    _messageController.dispose();
    _scrollController.dispose();
    _typingSub?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels <= 50) {
      context.read<ChatBloc>().add(const ChatLoadMoreMessages());
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    context.read<ChatBloc>().add(ChatSendMessage(text));
    _messageController.clear();
    context.read<ChatBloc>().add(const ChatTypingChanged(false));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final other = widget.otherUser;
    final avatarUrl = other != null && other['avatar'] != null ? '${AppConstants.baseUrl}${other['avatar']}' : null;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0.5,
        titleSpacing: 0,
        title: Row(
          children: [
            AvatarWidget(imageUrl: avatarUrl, radius: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          other?['name'] ?? 'Chat',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (other?['isVerified'] == true) ...[
                        const SizedBox(width: 4),
                        Icon(Icons.verified, size: 14, color: cs.primary),
                      ],
                    ],
                  ),
                  if (_isOtherTyping)
                    Text(
                      'Đang nhập...',
                      style: TextStyle(fontSize: 12, color: cs.primary, fontStyle: FontStyle.italic),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state.messagesStatus == ChatStatus.loaded && state.messages.isNotEmpty) {
                  _scrollToBottom();
                }
              },
              builder: (context, state) {
                if (state.messagesStatus == ChatStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.waving_hand, size: 48, color: cs.primary.withValues(alpha: 0.5)),
                        const SizedBox(height: 12),
                        Text('Hãy bắt đầu cuộc trò chuyện!', style: TextStyle(color: cs.onSurfaceVariant)),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final msg = state.messages[index] as Map<String, dynamic>;
                    final sender = msg['sender'] as Map<String, dynamic>?;
                    final isMe = sender?['id'] != other?['id'];
                    final prev = index > 0 ? state.messages[index - 1] as Map<String, dynamic> : null;
                    final showAvatar = !isMe && (prev == null || (prev['sender'] as Map?)?['id'] != sender?['id']);

                    return _MessageBubble(
                      message: msg,
                      isMe: isMe,
                      showAvatar: showAvatar,
                      otherAvatar: avatarUrl,
                    );
                  },
                );
              },
            ),
          ),

          // Input bar
          Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, MediaQuery.of(context).padding.bottom + 8),
            decoration: BoxDecoration(
              color: cs.surface,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, -1))],
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      hintStyle: TextStyle(color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
                      filled: true,
                      fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    onChanged: (text) {
                      context.read<ChatBloc>().add(ChatTypingChanged(text.isNotEmpty));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: cs.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isMe;
  final bool showAvatar;
  final String? otherAvatar;

  const _MessageBubble({
    required this.message,
    required this.isMe,
    required this.showAvatar,
    this.otherAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final content = message['content'] as String? ?? '';
    final createdAt = message['createdAt'] as String?;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && showAvatar)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: AvatarWidget(imageUrl: otherAvatar, radius: 14),
            )
          else if (!isMe)
            const SizedBox(width: 34),

          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isMe ? cs.primary : cs.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    content,
                    style: TextStyle(
                      color: isMe ? Colors.white : cs.onSurface,
                      fontSize: 15,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (createdAt != null)
                        Text(
                          _formatTime(createdAt),
                          style: TextStyle(
                            color: isMe ? Colors.white.withValues(alpha: 0.7) : cs.onSurfaceVariant,
                            fontSize: 10,
                          ),
                        ),
                      if (isMe && message['isRead'] == true) ...[
                        const SizedBox(width: 4),
                        Icon(Icons.done_all, size: 14, color: Colors.white.withValues(alpha: 0.7)),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(String dateStr) {
    try {
      final dt = DateTime.parse(dateStr).toLocal();
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }
}
