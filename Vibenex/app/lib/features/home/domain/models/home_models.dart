enum FriendStatus { none, pending, accepted }

class PostAuthor {
  final String id;
  final String name;
  final String avatar;
  final bool isVerified;
  final bool isFriend;

  PostAuthor({
    required this.id,
    required this.name,
    required this.avatar,
    this.isVerified = false,
    this.isFriend = false,
  });

  factory PostAuthor.fromJson(Map<String, dynamic> json) {
    return PostAuthor(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      isVerified: json['isVerified'] ?? false,
      isFriend: json['isFriend'] ?? false,
    );
  }
}

class PostModel {
  final String id;
  final PostAuthor author;
  final String content;
  final List<String> imageUrls;
  final String? videoUrl;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final bool isLiked;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.author,
    required this.content,
    this.imageUrls = const [],
    this.videoUrl,
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.isLiked = false,
    required this.createdAt,
  });

  PostModel copyWith({
    String? id,
    PostAuthor? author,
    String? content,
    List<String>? imageUrls,
    String? videoUrl,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    bool? isLiked,
    DateTime? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      imageUrls: imageUrls ?? this.imageUrls,
      videoUrl: videoUrl ?? this.videoUrl,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      isLiked: isLiked ?? this.isLiked,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      author: PostAuthor.fromJson(json['author'] ?? {}),
      content: json['content'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      videoUrl: json['videoUrl'],
      likeCount: json['likeCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      shareCount: json['shareCount'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }
}

class StoryModel {
  final String id;
  final String userName;
  final String userAvatar;
  final bool isOwn;
  final bool isViewed;

  StoryModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    this.isOwn = false,
    this.isViewed = false,
  });
}

class CommentModel {
  final String id;
  final String postId;
  final PostAuthor author;
  final String content;
  final String? parentId;
  final DateTime createdAt;
  final List<CommentModel>? children;

  CommentModel({
    required this.id,
    required this.postId,
    required this.author,
    required this.content,
    this.parentId,
    required this.createdAt,
    this.children,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      postId: json['postId'] ?? '',
      author: PostAuthor.fromJson(json['author'] ?? {}),
      content: json['content'] ?? '',
      parentId: json['parentId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      children: json['children'] != null
          ? (json['children'] as List).map((e) => CommentModel.fromJson(e)).toList()
          : null,
    );
  }
}
