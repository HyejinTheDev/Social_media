import 'dart:io';
import 'package:dio/dio.dart';
import '../../domain/models/post_models.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_api_service.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiService _api;
  final Dio _dio;

  PostRepositoryImpl({required PostApiService api, required Dio dio}) : _api = api, _dio = dio;

  @override
  Future<PaginatedPostsResponse> getFeed(int page, int limit) => _api.getFeed(page, limit);

  @override
  Future<PaginatedPostsResponse> getUserPosts(String userId, int page, int limit) => _api.getUserPosts(userId, page, limit);

  @override
  Future<PostModel> getPostById(String id) => _api.getPostById(id);

  @override
  Future<PostModel> createPost({
    required String content,
    List<File>? images,
    File? video,
    File? thumbnail,
  }) async {
    final formData = FormData.fromMap({'content': content});

    if (images != null && images.isNotEmpty) {
      for (var file in images) {
        formData.files.add(MapEntry(
          'images',
          await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
        ));
      }
    }

    if (video != null) {
      formData.files.add(MapEntry(
        'video',
        await MultipartFile.fromFile(video.path, filename: video.path.split('/').last),
      ));
    }

    if (thumbnail != null) {
      formData.files.add(MapEntry(
        'thumbnail',
        await MultipartFile.fromFile(thumbnail.path, filename: thumbnail.path.split('/').last),
      ));
    }

    final response = await _dio.post('/posts', data: formData);
    return PostModel.fromJson(response.data);
  }

  @override
  Future<void> deletePost(String id) => _api.deletePost(id);

  @override
  Future<bool> toggleLike(String id) async {
    final res = await _api.toggleLike(id);
    return res['liked'] == true;
  }

  @override
  Future<bool> getLikeStatus(String id) async {
    final res = await _api.getLikeStatus(id);
    return res['liked'] == true;
  }

  @override
  Future<PaginatedCommentsResponse> getComments(String postId, int page, int limit) => _api.getComments(postId, page, limit);

  @override
  Future<CommentModel> addComment(String postId, String content) => _api.addComment(postId, {'content': content});

  @override
  Future<void> deleteComment(String id) => _api.deleteComment(id);
}
