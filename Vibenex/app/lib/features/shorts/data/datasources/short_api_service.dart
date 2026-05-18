import 'dart:io';
import 'package:dio/dio.dart';

class ShortApiService {
  final Dio _dio;

  ShortApiService(this._dio);

  Future<Map<String, dynamic>> getFeed(int page, {int limit = 10}) async {
    final response = await _dio.get('/shorts/feed', queryParameters: {
      'page': page,
      'limit': limit,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> getShortById(String id) async {
    final response = await _dio.get('/shorts/$id');
    return response.data;
  }

  Future<Map<String, dynamic>> toggleLike(String shortId) async {
    final response = await _dio.post('/shorts/$shortId/like');
    return response.data;
  }

  Future<Map<String, dynamic>> createShort({
    required String videoUrl,
    String? caption,
    String? thumbnailUrl,
  }) async {
    final response = await _dio.post('/shorts', data: {
      'videoUrl': videoUrl,
      'caption': caption,
      'thumbnailUrl': thumbnailUrl,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> uploadShortMedia(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });
    final response = await _dio.post('/shorts/upload', data: formData);
    return response.data;
  }

  Future<List<dynamic>> getComments(String shortId) async {
    final response = await _dio.get('/shorts/$shortId/comments');
    return response.data;
  }

  Future<Map<String, dynamic>> createComment(String shortId, String content) async {
    final response = await _dio.post('/shorts/$shortId/comments', data: {
      'content': content,
    });
    return response.data;
  }
}
