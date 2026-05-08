import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../auth/domain/models/auth_models.dart';

part 'post_models.freezed.dart';
part 'post_models.g.dart';

@freezed
abstract class PostModel with _$PostModel {
  const factory PostModel({
    required String id,
    required String authorId,
    required UserModel author,
    required String content,
    @Default([]) List<String> imageUrls,
    String? videoUrl,
    String? videoThumbnailUrl,
    @Default('TEXT') String mediaType,
    @Default(0) int likesCount,
    @Default(0) int commentsCount,
    @Default(0) int sharesCount,
    required String createdAt,
    required String updatedAt,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
}

@freezed
abstract class CommentModel with _$CommentModel {
  const factory CommentModel({
    required String id,
    required String postId,
    required String authorId,
    required UserModel author,
    required String content,
    required String createdAt,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
}

@freezed
abstract class PaginatedPostsResponse with _$PaginatedPostsResponse {
  const factory PaginatedPostsResponse({
    required List<PostModel> posts,
    required int total,
    required int page,
    required int totalPages,
  }) = _PaginatedPostsResponse;

  factory PaginatedPostsResponse.fromJson(Map<String, dynamic> json) => _$PaginatedPostsResponseFromJson(json);
}

@freezed
abstract class PaginatedCommentsResponse with _$PaginatedCommentsResponse {
  const factory PaginatedCommentsResponse({
    required List<CommentModel> comments,
    required int total,
    required int page,
    required int totalPages,
  }) = _PaginatedCommentsResponse;

  factory PaginatedCommentsResponse.fromJson(Map<String, dynamic> json) => _$PaginatedCommentsResponseFromJson(json);
}
