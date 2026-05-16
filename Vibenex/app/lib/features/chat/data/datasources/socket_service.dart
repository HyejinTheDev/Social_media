import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/app_constants.dart';

class SocketService {
  io.Socket? _socket;
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();
  final _typingController = StreamController<Map<String, dynamic>>.broadcast();
  final _readController = StreamController<Map<String, dynamic>>.broadcast();
  final _onlineController = StreamController<Map<String, dynamic>>.broadcast();
  final _notificationController = StreamController<Map<String, dynamic>>.broadcast();
  final _channelMessageController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get onNewMessage => _messageController.stream;
  Stream<Map<String, dynamic>> get onTyping => _typingController.stream;
  Stream<Map<String, dynamic>> get onRead => _readController.stream;
  Stream<Map<String, dynamic>> get onOnlineStatus => _onlineController.stream;
  Stream<Map<String, dynamic>> get onNewNotification => _notificationController.stream;
  Stream<Map<String, dynamic>> get onNewChannelMessage => _channelMessageController.stream;

  bool get isConnected => _socket?.connected ?? false;

  Future<void> connect() async {
    if (_socket != null && _socket!.connected) return;

    final token = await const FlutterSecureStorage().read(key: AppConstants.accessTokenKey);
    if (token == null) return;

    _socket = io.io(
      '${AppConstants.baseUrl}/chat',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .disableAutoConnect()
          .build(),
    );

    _socket!.onConnect((_) {
      debugPrint('🟢 Socket connected');
    });

    _socket!.onDisconnect((_) {
      debugPrint('🔴 Socket disconnected');
    });

    _socket!.onConnectError((e) {
      debugPrint('❌ Socket connect error: $e');
    });

    // Listen for events
    _socket!.on('message:new', (data) {
      _messageController.add(Map<String, dynamic>.from(data));
    });

    _socket!.on('message:typing', (data) {
      _typingController.add(Map<String, dynamic>.from(data));
    });

    _socket!.on('message:read', (data) {
      _readController.add(Map<String, dynamic>.from(data));
    });

    _socket!.on('user:online', (data) {
      _onlineController.add(Map<String, dynamic>.from(data));
    });

    _socket!.on('notification:new', (data) {
      _notificationController.add(Map<String, dynamic>.from(data));
    });

    _socket!.on('channel:message:new', (data) {
      _channelMessageController.add(Map<String, dynamic>.from(data));
    });

    _socket!.connect();
  }

  void joinConversation(String conversationId) {
    _socket?.emit('conversation:join', {'conversationId': conversationId});
  }

  void leaveConversation(String conversationId) {
    _socket?.emit('conversation:leave', {'conversationId': conversationId});
  }

  void sendMessage(String conversationId, String content, {String? imageUrl}) {
    _socket?.emit('message:send', {
      'conversationId': conversationId,
      'content': content,
      if (imageUrl != null) 'imageUrl': imageUrl,
    });
  }

  void sendTyping(String conversationId, bool typing) {
    _socket?.emit('message:typing', {
      'conversationId': conversationId,
      'typing': typing,
    });
  }

  void markRead(String conversationId) {
    _socket?.emit('message:read', {'conversationId': conversationId});
  }

  // --- Channel Methods ---
  void joinChannel(String channelId) {
    _socket?.emit('channel:join', {'channelId': channelId});
  }

  void leaveChannel(String channelId) {
    _socket?.emit('channel:leave', {'channelId': channelId});
  }

  void sendChannelMessage(String channelId, String content, {String? imageUrl}) {
    _socket?.emit('channel:message:send', {
      'channelId': channelId,
      'content': content,
      if (imageUrl != null) 'imageUrl': imageUrl,
    });
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }

  void dispose() {
    disconnect();
    _messageController.close();
    _typingController.close();
    _readController.close();
    _onlineController.close();
    _notificationController.close();
    _channelMessageController.close();
  }
}
