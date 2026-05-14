import 'package:injectable/injectable.dart';
import 'dart:io';
import '../../domain/models/home_models.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_api_service.dart';

@Injectable(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostApiService _apiService;

  PostRepositoryImpl(this._apiService);

  @override
  Future<List<PostModel>> getFeed({required int page, required int limit}) async {
    final response = await _apiService.getFeed(page, limit);
    final data = response['data'] as List;
    return data.map((e) => PostModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<PostModel>> getUserPosts(String userId, {required int page, required int limit}) async {
    final response = await _apiService.getUserPosts(userId, page, limit);
    final data = response['data'] as List;
    return data.map((e) => PostModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<PostModel> createPost({
    required String content,
    List<String>? imageUrls,
    String? videoUrl,
  }) async {
    final response = await _apiService.createPost({
      'content': content,
      if (imageUrls != null) 'imageUrls': imageUrls,
      if (videoUrl != null) 'videoUrl': videoUrl,
    });
    return PostModel.fromJson(response);
  }

  @override
  Future<bool> toggleLike(String postId) async {
    final response = await _apiService.toggleLike(postId);
    return response['liked'] as bool;
  }

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    final response = await _apiService.getComments(postId);
    final data = response as List;
    return data.map((e) => CommentModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<CommentModel> createComment(String postId, String content, {String? parentId}) async {
    final response = await _apiService.createComment(postId, {
      'content': content,
      if (parentId != null) 'parentId': parentId,
    });
    return CommentModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<String> uploadMedia(File file) async {
    final response = await _apiService.uploadMedia(file);
    return response['url'] as String;
  }
}
