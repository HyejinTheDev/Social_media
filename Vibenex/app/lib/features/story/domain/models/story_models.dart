import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../auth/domain/models/auth_models.dart';

part 'story_models.freezed.dart';
part 'story_models.g.dart';

@freezed
abstract class StoryModel with _$StoryModel {
  const factory StoryModel({
    required String id,
    required String authorId,
    required UserModel author,
    required String mediaUrl,
    @Default('IMAGE') String mediaType,
    String? caption,
    @Default(0) int viewCount,
    required String expiresAt,
    required String createdAt,
    @Default(false) bool isViewed,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) => _$StoryModelFromJson(json);
}

@freezed
abstract class StoryGroup with _$StoryGroup {
  const factory StoryGroup({
    required UserModel author,
    required List<StoryModel> stories,
    @Default(false) bool hasUnviewed,
  }) = _StoryGroup;

  factory StoryGroup.fromJson(Map<String, dynamic> json) => _$StoryGroupFromJson(json);
}

@freezed
abstract class StoryGroupsResponse with _$StoryGroupsResponse {
  const factory StoryGroupsResponse({
    required List<StoryGroup> groups,
  }) = _StoryGroupsResponse;

  factory StoryGroupsResponse.fromJson(Map<String, dynamic> json) => _$StoryGroupsResponseFromJson(json);
}

@freezed
abstract class StoryViewerModel with _$StoryViewerModel {
  const factory StoryViewerModel({
    required String id,
    required String viewerId,
    required UserModel viewer,
    required String viewedAt,
  }) = _StoryViewerModel;

  factory StoryViewerModel.fromJson(Map<String, dynamic> json) => _$StoryViewerModelFromJson(json);
}

@freezed
abstract class MyStoriesResponse with _$MyStoriesResponse {
  const factory MyStoriesResponse({
    required List<MyStoryDetail> stories,
  }) = _MyStoriesResponse;

  factory MyStoriesResponse.fromJson(Map<String, dynamic> json) => _$MyStoriesResponseFromJson(json);
}

@freezed
abstract class MyStoryDetail with _$MyStoryDetail {
  const factory MyStoryDetail({
    required String id,
    required String authorId,
    required String mediaUrl,
    @Default('IMAGE') String mediaType,
    String? caption,
    @Default(0) int viewCount,
    required String expiresAt,
    required String createdAt,
    @Default([]) List<StoryViewerModel> views,
  }) = _MyStoryDetail;

  factory MyStoryDetail.fromJson(Map<String, dynamic> json) => _$MyStoryDetailFromJson(json);
}
