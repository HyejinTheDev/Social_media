import 'package:dio/dio.dart';

class ChatApiService {
  final Dio _dio;

  ChatApiService(this._dio);

  Future<List<dynamic>> getConversations() async {
    final response = await _dio.get('/chat/conversations');
    return response.data as List<dynamic>;
  }

  Future<Map<String, dynamic>> getOrCreateConversation(String userId) async {
    final response = await _dio.post('/chat/conversations/$userId');
    return response.data;
  }

  Future<Map<String, dynamic>> getMessages(String conversationId, int page) async {
    final response = await _dio.get(
      '/chat/conversations/$conversationId/messages',
      queryParameters: {'page': page},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> sendMessage(String conversationId, String content, {String? imageUrl}) async {
    final response = await _dio.post(
      '/chat/conversations/$conversationId/messages',
      data: {'content': content, if (imageUrl != null) 'imageUrl': imageUrl},
    );
    return response.data;
  }

  Future<void> markAsRead(String conversationId) async {
    await _dio.post('/chat/conversations/$conversationId/read');
  }

  Future<int> getUnreadCount(String conversationId) async {
    final response = await _dio.get('/chat/conversations/$conversationId/unread');
    return response.data['unreadCount'] ?? 0;
  }

  Future<void> deleteMessage(String messageId) async {
    await _dio.delete('/chat/messages/$messageId');
  }
}
