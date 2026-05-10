// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => _StoryModel(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      mediaUrl: json['mediaUrl'] as String,
      mediaType: json['mediaType'] as String? ?? 'IMAGE',
      caption: json['caption'] as String?,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      expiresAt: json['expiresAt'] as String,
      createdAt: json['createdAt'] as String,
      isViewed: json['isViewed'] as bool? ?? false,
    );

Map<String, dynamic> _$StoryModelToJson(_StoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'author': instance.author,
      'mediaUrl': instance.mediaUrl,
      'mediaType': instance.mediaType,
      'caption': instance.caption,
      'viewCount': instance.viewCount,
      'expiresAt': instance.expiresAt,
      'createdAt': instance.createdAt,
      'isViewed': instance.isViewed,
    };

_StoryGroup _$StoryGroupFromJson(Map<String, dynamic> json) => _StoryGroup(
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      stories: (json['stories'] as List<dynamic>)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasUnviewed: json['hasUnviewed'] as bool? ?? false,
    );

Map<String, dynamic> _$StoryGroupToJson(_StoryGroup instance) =>
    <String, dynamic>{
      'author': instance.author,
      'stories': instance.stories,
      'hasUnviewed': instance.hasUnviewed,
    };

_StoryGroupsResponse _$StoryGroupsResponseFromJson(Map<String, dynamic> json) =>
    _StoryGroupsResponse(
      groups: (json['groups'] as List<dynamic>)
          .map((e) => StoryGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoryGroupsResponseToJson(
        _StoryGroupsResponse instance) =>
    <String, dynamic>{
      'groups': instance.groups,
    };

_StoryViewerModel _$StoryViewerModelFromJson(Map<String, dynamic> json) =>
    _StoryViewerModel(
      id: json['id'] as String,
      viewerId: json['viewerId'] as String,
      viewer: UserModel.fromJson(json['viewer'] as Map<String, dynamic>),
      viewedAt: json['viewedAt'] as String,
    );

Map<String, dynamic> _$StoryViewerModelToJson(_StoryViewerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'viewerId': instance.viewerId,
      'viewer': instance.viewer,
      'viewedAt': instance.viewedAt,
    };

_MyStoriesResponse _$MyStoriesResponseFromJson(Map<String, dynamic> json) =>
    _MyStoriesResponse(
      stories: (json['stories'] as List<dynamic>)
          .map((e) => MyStoryDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyStoriesResponseToJson(_MyStoriesResponse instance) =>
    <String, dynamic>{
      'stories': instance.stories,
    };

_MyStoryDetail _$MyStoryDetailFromJson(Map<String, dynamic> json) =>
    _MyStoryDetail(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      mediaUrl: json['mediaUrl'] as String,
      mediaType: json['mediaType'] as String? ?? 'IMAGE',
      caption: json['caption'] as String?,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      expiresAt: json['expiresAt'] as String,
      createdAt: json['createdAt'] as String,
      views: (json['views'] as List<dynamic>?)
              ?.map((e) => StoryViewerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MyStoryDetailToJson(_MyStoryDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'mediaUrl': instance.mediaUrl,
      'mediaType': instance.mediaType,
      'caption': instance.caption,
      'viewCount': instance.viewCount,
      'expiresAt': instance.expiresAt,
      'createdAt': instance.createdAt,
      'views': instance.views,
    };
