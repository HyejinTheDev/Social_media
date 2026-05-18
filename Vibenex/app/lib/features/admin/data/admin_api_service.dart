import 'package:dio/dio.dart';

class AdminApiService {
  final Dio _dio;

  AdminApiService(this._dio);

  // ── Dashboard ──
  Future<Map<String, dynamic>> getStats() async {
    final res = await _dio.get('/admin/stats');
    return res.data;
  }

  // ── Users ──
  Future<Map<String, dynamic>> getUsers(int page, {String? search}) async {
    final res = await _dio.get('/admin/users', queryParameters: {
      'page': page,
      if (search != null && search.isNotEmpty) 'search': search,
    });
    return res.data;
  }

  Future<void> deleteUser(String userId) async {
    await _dio.delete('/admin/users/$userId');
  }

  Future<Map<String, dynamic>> toggleVerify(String userId) async {
    final res = await _dio.patch('/admin/users/$userId/verify');
    return res.data;
  }

  // ── Posts ──
  Future<Map<String, dynamic>> getPosts(int page, {String? search}) async {
    final res = await _dio.get('/admin/posts', queryParameters: {
      'page': page,
      if (search != null && search.isNotEmpty) 'search': search,
    });
    return res.data;
  }

  Future<void> deletePost(String postId) async {
    await _dio.delete('/admin/posts/$postId');
  }

  // ── Shorts ──
  Future<Map<String, dynamic>> getShorts(int page) async {
    final res = await _dio.get('/admin/shorts', queryParameters: {'page': page});
    return res.data;
  }

  Future<void> deleteShort(String shortId) async {
    await _dio.delete('/admin/shorts/$shortId');
  }

  // ── Communities ──
  Future<Map<String, dynamic>> getCommunities(int page, {String? search}) async {
    final res = await _dio.get('/admin/communities', queryParameters: {
      'page': page,
      if (search != null && search.isNotEmpty) 'search': search,
    });
    return res.data;
  }

  Future<void> deleteCommunity(String communityId) async {
    await _dio.delete('/admin/communities/$communityId');
  }
}
