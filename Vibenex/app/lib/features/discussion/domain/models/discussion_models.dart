import 'package:freezed_annotation/freezed_annotation.dart';

part 'discussion_models.freezed.dart';
part 'discussion_models.g.dart';

/// A single discussion thread within a channel.
@freezed
abstract class DiscussionModel with _$DiscussionModel {
  const factory DiscussionModel({
    required String id,
    required String channelId,
    required String authorId,
    required String content,
    @Default([]) List<String> imageUrls,
    String? linkUrl,
    @Default(false) bool isPinned,
    @Default(0) int replyCount,
    @Default(0) int reactionCount,
    AuthorModel? author,
    String? createdAt,
    String? updatedAt,
  }) = _DiscussionModel;

  factory DiscussionModel.fromJson(Map<String, dynamic> json) =>
      _$DiscussionModelFromJson(json);
}

/// A reply to a discussion (supports nested threading via parentId).
@freezed
abstract class ReplyModel with _$ReplyModel {
  const factory ReplyModel({
    required String id,
    required String discussionId,
    String? parentId,
    required String authorId,
    required String content,
    AuthorModel? author,
    @Default([]) List<ReplyModel> children,
    String? createdAt,
  }) = _ReplyModel;

  factory ReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyModelFromJson(json);
}

/// Lightweight author info embedded in discussions/replies.
@freezed
abstract class AuthorModel with _$AuthorModel {
  const factory AuthorModel({
    required String id,
    required String name,
    required String username,
    String? avatar,
  }) = _AuthorModel;

  factory AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);
}

/// Paginated response wrapper for discussions.
@freezed
abstract class PaginatedDiscussionsResponse with _$PaginatedDiscussionsResponse {
  const factory PaginatedDiscussionsResponse({
    required List<DiscussionModel> discussions,
    required int total,
  }) = _PaginatedDiscussionsResponse;

  factory PaginatedDiscussionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedDiscussionsResponseFromJson(json);
}
