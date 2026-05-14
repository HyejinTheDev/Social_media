import 'dart:io';
import '../../domain/models/home_models.dart';

abstract class PostRepository {
  Future<List<PostModel>> getFeed({required int page, required int limit});
  Future<List<PostModel>> getUserPosts(String userId, {required int page, required int limit});
  Future<PostModel> createPost({
    required String content,
    List<String>? imageUrls,
    String? videoUrl,
  });
  Future<bool> toggleLike(String postId);
  Future<List<CommentModel>> getComments(String postId);
  Future<CommentModel> createComment(String postId, String content, {String? parentId});
  Future<String> uploadMedia(File file);
}
