import 'package:equatable/equatable.dart';

class ShortModel extends Equatable {
  final String id;
  final String authorId;
  final String videoUrl;
  final String? caption;
  final String? thumbnailUrl;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final DateTime createdAt;

  final String authorName;
  final String authorAvatar;
  final bool isLikedByMe;

  const ShortModel({
    required this.id,
    required this.authorId,
    required this.videoUrl,
    this.caption,
    this.thumbnailUrl,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.createdAt,
    required this.authorName,
    required this.authorAvatar,
    required this.isLikedByMe,
  });

  factory ShortModel.fromJson(Map<String, dynamic> json, String currentUserId) {
    final author = json['author'] ?? {};
    final likes = json['likes'] as List<dynamic>? ?? [];
    
    return ShortModel(
      id: json['id'] ?? '',
      authorId: json['authorId'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      caption: json['caption'],
      thumbnailUrl: json['thumbnailUrl'],
      likeCount: json['likeCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      shareCount: json['shareCount'] ?? 0,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      authorName: author['name'] ?? author['username'] ?? 'User',
      authorAvatar: author['avatar'] ?? 'https://i.pravatar.cc/150?u=${json['authorId']}',
      isLikedByMe: likes.any((like) => like['userId'] == currentUserId),
    );
  }

  ShortModel copyWith({
    int? likeCount,
    bool? isLikedByMe,
  }) {
    return ShortModel(
      id: id,
      authorId: authorId,
      videoUrl: videoUrl,
      caption: caption,
      thumbnailUrl: thumbnailUrl,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount,
      shareCount: shareCount,
      createdAt: createdAt,
      authorName: authorName,
      authorAvatar: authorAvatar,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
    );
  }

  @override
  List<Object?> get props => [
        id,
        authorId,
        videoUrl,
        caption,
        thumbnailUrl,
        likeCount,
        commentCount,
        shareCount,
        createdAt,
        authorName,
        authorAvatar,
        isLikedByMe,
      ];
}
