import 'dart:io';
import '../../domain/models/post_models.dart';

abstract class PostRepository {
  Future<PaginatedPostsResponse> getFeed(int page, int limit);
  Future<PaginatedPostsResponse> getUserPosts(String userId, int page, int limit);
  Future<PostModel> getPostById(String id);
  Future<PostModel> createPost({
    required String content,
    List<File>? images,
    File? video,
    File? thumbnail,
  });
  Future<void> deletePost(String id);
  Future<bool> toggleLike(String id);
  Future<bool> getLikeStatus(String id);

  Future<PaginatedCommentsResponse> getComments(String postId, int page, int limit);
  Future<CommentModel> addComment(String postId, String content);
  Future<void> deleteComment(String id);
}
