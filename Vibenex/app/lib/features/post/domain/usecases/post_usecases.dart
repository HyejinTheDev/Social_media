import 'dart:io';
import '../models/post_models.dart';
import '../repositories/post_repository.dart';

class GetFeedUseCase {
  final PostRepository repository;
  GetFeedUseCase(this.repository);
  Future<PaginatedPostsResponse> call({int page = 1, int limit = 10}) => repository.getFeed(page, limit);
}

class GetUserPostsUseCase {
  final PostRepository repository;
  GetUserPostsUseCase(this.repository);
  Future<PaginatedPostsResponse> call(String userId, {int page = 1, int limit = 10}) => repository.getUserPosts(userId, page, limit);
}

class CreatePostUseCase {
  final PostRepository repository;
  CreatePostUseCase(this.repository);
  Future<PostModel> call({
    required String content,
    List<File>? images,
    File? video,
    File? thumbnail,
  }) => repository.createPost(content: content, images: images, video: video, thumbnail: thumbnail);
}

class DeletePostUseCase {
  final PostRepository repository;
  DeletePostUseCase(this.repository);
  Future<void> call(String id) => repository.deletePost(id);
}

class ToggleLikeUseCase {
  final PostRepository repository;
  ToggleLikeUseCase(this.repository);
  Future<bool> call(String id) => repository.toggleLike(id);
}

class GetCommentsUseCase {
  final PostRepository repository;
  GetCommentsUseCase(this.repository);
  Future<PaginatedCommentsResponse> call(String postId, {int page = 1, int limit = 20}) => repository.getComments(postId, page, limit);
}

class AddCommentUseCase {
  final PostRepository repository;
  AddCommentUseCase(this.repository);
  Future<CommentModel> call(String postId, String content) => repository.addComment(postId, content);
}

class DeleteCommentUseCase {
  final PostRepository repository;
  DeleteCommentUseCase(this.repository);
  Future<void> call(String id) => repository.deleteComment(id);
}
