import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../chat/data/datasources/socket_service.dart';
import '../../../../core/network/dio_client.dart';

class LiveChatChannelPage extends StatefulWidget {
  final String communityId;
  final String channelId;
  final String channelName;
  final String communityName;

  const LiveChatChannelPage({
    super.key,
    required this.communityId,
    required this.channelId,
    required this.channelName,
    required this.communityName,
  });

  @override
  State<LiveChatChannelPage> createState() => _LiveChatChannelPageState();
}

class _LiveChatChannelPageState extends State<LiveChatChannelPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _socketService = getIt<SocketService>();
  final _dio = getIt<DioClient>().dio;

  List<dynamic> _messages = [];
  bool _loading = true;
  StreamSubscription? _sub;
  String? _myUserId;

  @override
  void initState() {
    super.initState();
    _initMyUserId();
    _loadMessages();
    
    // Connect socket if not connected
    if (!_socketService.isConnected) {
      _socketService.connect();
    }
    
    _socketService.joinChannel(widget.channelId);
    
    _sub = _socketService.onNewChannelMessage.listen((data) {
      if (data['channelId'] == widget.channelId) {
        if (mounted) {
          setState(() {
            _messages.insert(0, data);
          });
        }
      }
    });
  }

  void _initMyUserId() {
    final authState = getIt<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _myUserId = authState.user.id;
    }
  }

  Future<void> _loadMessages() async {
    try {
      final response = await _dio.get('/communities/channels/${widget.channelId}/messages', queryParameters: {'limit': 50});
      if (mounted) {
        setState(() {
          _messages = response.data['data'];
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    
    _socketService.sendChannelMessage(widget.channelId, text);
    _messageController.clear();
  }

  @override
  void dispose() {
    _socketService.leaveChannel(widget.channelId);
    _sub?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceMidnight,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.chat_bubble_outline, color: AppColors.textFog, size: 16),
                const SizedBox(width: 6),
                Text(
                  widget.channelName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textSilver),
                ),
              ],
            ),
            Text(
              widget.communityName,
              style: const TextStyle(fontSize: 11, color: AppColors.brandViolet),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_alt_outlined, color: AppColors.textFog),
            onPressed: () {}, 
          ),
        ],
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: _loading 
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: _scrollController,
                  reverse: true, // Show newest at bottom
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final sender = msg['sender'];
                    final isMe = sender['id'] == _myUserId;
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(sender['avatar'] ?? 'https://i.pravatar.cc/150'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      sender['name'] ?? sender['username'],
                                      style: TextStyle(
                                        color: isMe ? AppColors.brandViolet : AppColors.textSilver,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      timeago.format(DateTime.parse(msg['createdAt']), locale: 'vi'),
                                      style: const TextStyle(color: AppColors.textFog, fontSize: 11),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  msg['content'],
                                  style: const TextStyle(color: AppColors.onSurfaceVariant, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          ),
          
          // Input box
          Container(
            padding: EdgeInsets.only(
              left: 12,
              right: 4,
              top: 8,
              bottom: MediaQuery.of(context).padding.bottom + 8,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surfaceMidnight,
              border: Border(top: BorderSide(color: AppColors.borderTwilight)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: AppColors.textSilver, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Nhắn tin vào #${widget.channelName}',
                      hintStyle: const TextStyle(color: AppColors.textFog),
                      filled: true,
                      fillColor: AppColors.surfaceContainerHigh,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: AppColors.brandViolet),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
