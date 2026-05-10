import 'package:dio/dio.dart';

class FollowApiService {
  final Dio _dio;

  FollowApiService(this._dio);

  Future<Map<String, dynamic>> follow(String userId) async {
    final response = await _dio.post('/follow/$userId');
    return response.data;
  }

  Future<Map<String, dynamic>> unfollow(String userId) async {
    final response = await _dio.delete('/follow/$userId');
    return response.data;
  }

  Future<Map<String, dynamic>> getFollowStatus(String userId) async {
    final response = await _dio.get('/follow/$userId/status');
    return response.data;
  }

  Future<Map<String, dynamic>> getFollowers(String userId, int page) async {
    final response = await _dio.get('/follow/$userId/followers', queryParameters: {'page': page});
    return response.data;
  }

  Future<Map<String, dynamic>> getFollowing(String userId, int page) async {
    final response = await _dio.get('/follow/$userId/following', queryParameters: {'page': page});
    return response.data;
  }

  Future<Map<String, dynamic>> searchUsers(String query, int page) async {
    final response = await _dio.get('/users/search', queryParameters: {'q': query, 'page': page});
    return response.data;
  }
}
