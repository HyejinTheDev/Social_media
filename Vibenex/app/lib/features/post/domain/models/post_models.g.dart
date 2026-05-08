// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostModel _$PostModelFromJson(Map<String, dynamic> json) => _PostModel(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      content: json['content'] as String,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      videoUrl: json['videoUrl'] as String?,
      videoThumbnailUrl: json['videoThumbnailUrl'] as String?,
      mediaType: json['mediaType'] as String? ?? 'TEXT',
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
      sharesCount: (json['sharesCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$PostModelToJson(_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'author': instance.author,
      'content': instance.content,
      'imageUrls': instance.imageUrls,
      'videoUrl': instance.videoUrl,
      'videoThumbnailUrl': instance.videoThumbnailUrl,
      'mediaType': instance.mediaType,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'sharesCount': instance.sharesCount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    _CommentModel(
      id: json['id'] as String,
      postId: json['postId'] as String,
      authorId: json['authorId'] as String,
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      content: json['content'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CommentModelToJson(_CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'authorId': instance.authorId,
      'author': instance.author,
      'content': instance.content,
      'createdAt': instance.createdAt,
    };

_PaginatedPostsResponse _$PaginatedPostsResponseFromJson(
        Map<String, dynamic> json) =>
    _PaginatedPostsResponse(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$PaginatedPostsResponseToJson(
        _PaginatedPostsResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'total': instance.total,
      'page': instance.page,
      'totalPages': instance.totalPages,
    };

_PaginatedCommentsResponse _$PaginatedCommentsResponseFromJson(
        Map<String, dynamic> json) =>
    _PaginatedCommentsResponse(
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$PaginatedCommentsResponseToJson(
        _PaginatedCommentsResponse instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'total': instance.total,
      'page': instance.page,
      'totalPages': instance.totalPages,
    };
