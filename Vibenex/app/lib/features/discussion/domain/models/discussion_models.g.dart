// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discussion_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiscussionModel _$DiscussionModelFromJson(Map<String, dynamic> json) =>
    _DiscussionModel(
      id: json['id'] as String,
      channelId: json['channelId'] as String,
      authorId: json['authorId'] as String,
      content: json['content'] as String,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      linkUrl: json['linkUrl'] as String?,
      isPinned: json['isPinned'] as bool? ?? false,
      replyCount: (json['replyCount'] as num?)?.toInt() ?? 0,
      reactionCount: (json['reactionCount'] as num?)?.toInt() ?? 0,
      author: json['author'] == null
          ? null
          : AuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$DiscussionModelToJson(_DiscussionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelId': instance.channelId,
      'authorId': instance.authorId,
      'content': instance.content,
      'imageUrls': instance.imageUrls,
      'linkUrl': instance.linkUrl,
      'isPinned': instance.isPinned,
      'replyCount': instance.replyCount,
      'reactionCount': instance.reactionCount,
      'author': instance.author,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_ReplyModel _$ReplyModelFromJson(Map<String, dynamic> json) => _ReplyModel(
      id: json['id'] as String,
      discussionId: json['discussionId'] as String,
      parentId: json['parentId'] as String?,
      authorId: json['authorId'] as String,
      content: json['content'] as String,
      author: json['author'] == null
          ? null
          : AuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => ReplyModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ReplyModelToJson(_ReplyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'discussionId': instance.discussionId,
      'parentId': instance.parentId,
      'authorId': instance.authorId,
      'content': instance.content,
      'author': instance.author,
      'children': instance.children,
      'createdAt': instance.createdAt,
    };

_AuthorModel _$AuthorModelFromJson(Map<String, dynamic> json) => _AuthorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$AuthorModelToJson(_AuthorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'avatar': instance.avatar,
    };

_PaginatedDiscussionsResponse _$PaginatedDiscussionsResponseFromJson(
        Map<String, dynamic> json) =>
    _PaginatedDiscussionsResponse(
      discussions: (json['discussions'] as List<dynamic>)
          .map((e) => DiscussionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PaginatedDiscussionsResponseToJson(
        _PaginatedDiscussionsResponse instance) =>
    <String, dynamic>{
      'discussions': instance.discussions,
      'total': instance.total,
    };
