// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostModel {
  String get id;
  String get authorId;
  UserModel get author;
  String get content;
  List<String> get imageUrls;
  String? get videoUrl;
  String? get videoThumbnailUrl;
  String get mediaType;
  int get likesCount;
  int get commentsCount;
  int get sharesCount;
  String get createdAt;
  String get updatedAt;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostModelCopyWith<PostModel> get copyWith =>
      _$PostModelCopyWithImpl<PostModel>(this as PostModel, _$identity);

  /// Serializes this PostModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other.imageUrls, imageUrls) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.videoThumbnailUrl, videoThumbnailUrl) ||
                other.videoThumbnailUrl == videoThumbnailUrl) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.sharesCount, sharesCount) ||
                other.sharesCount == sharesCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      author,
      content,
      const DeepCollectionEquality().hash(imageUrls),
      videoUrl,
      videoThumbnailUrl,
      mediaType,
      likesCount,
      commentsCount,
      sharesCount,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'PostModel(id: $id, authorId: $authorId, author: $author, content: $content, imageUrls: $imageUrls, videoUrl: $videoUrl, videoThumbnailUrl: $videoThumbnailUrl, mediaType: $mediaType, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) _then) =
      _$PostModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String authorId,
      UserModel author,
      String content,
      List<String> imageUrls,
      String? videoUrl,
      String? videoThumbnailUrl,
      String mediaType,
      int likesCount,
      int commentsCount,
      int sharesCount,
      String createdAt,
      String updatedAt});

  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res> implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._self, this._then);

  final PostModel _self;
  final $Res Function(PostModel) _then;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? author = null,
    Object? content = null,
    Object? imageUrls = null,
    Object? videoUrl = freezed,
    Object? videoThumbnailUrl = freezed,
    Object? mediaType = null,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? sharesCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: null == imageUrls
          ? _self.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      videoUrl: freezed == videoUrl
          ? _self.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoThumbnailUrl: freezed == videoThumbnailUrl
          ? _self.videoThumbnailUrl
          : videoThumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaType: null == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      likesCount: null == likesCount
          ? _self.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _self.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      sharesCount: null == sharesCount
          ? _self.sharesCount
          : sharesCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get author {
    return $UserModelCopyWith<$Res>(_self.author, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// Adds pattern-matching-related methods to [PostModel].
extension PostModelPatterns on PostModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PostModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PostModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PostModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String authorId,
            UserModel author,
            String content,
            List<String> imageUrls,
            String? videoUrl,
            String? videoThumbnailUrl,
            String mediaType,
            int likesCount,
            int commentsCount,
            int sharesCount,
            String createdAt,
            String updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostModel() when $default != null:
        return $default(
            _that.id,
            _that.authorId,
            _that.author,
            _that.content,
            _that.imageUrls,
            _that.videoUrl,
            _that.videoThumbnailUrl,
            _that.mediaType,
            _that.likesCount,
            _that.commentsCount,
            _that.sharesCount,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String authorId,
            UserModel author,
            String content,
            List<String> imageUrls,
            String? videoUrl,
            String? videoThumbnailUrl,
            String mediaType,
            int likesCount,
            int commentsCount,
            int sharesCount,
            String createdAt,
            String updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostModel():
        return $default(
            _that.id,
            _that.authorId,
            _that.author,
            _that.content,
            _that.imageUrls,
            _that.videoUrl,
            _that.videoThumbnailUrl,
            _that.mediaType,
            _that.likesCount,
            _that.commentsCount,
            _that.sharesCount,
            _that.createdAt,
            _that.updatedAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String authorId,
            UserModel author,
            String content,
            List<String> imageUrls,
            String? videoUrl,
            String? videoThumbnailUrl,
            String mediaType,
            int likesCount,
            int commentsCount,
            int sharesCount,
            String createdAt,
            String updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostModel() when $default != null:
        return $default(
            _that.id,
            _that.authorId,
            _that.author,
            _that.content,
            _that.imageUrls,
            _that.videoUrl,
            _that.videoThumbnailUrl,
            _that.mediaType,
            _that.likesCount,
            _that.commentsCount,
            _that.sharesCount,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PostModel implements PostModel {
  const _PostModel(
      {required this.id,
      required this.authorId,
      required this.author,
      required this.content,
      final List<String> imageUrls = const [],
      this.videoUrl,
      this.videoThumbnailUrl,
      this.mediaType = 'TEXT',
      this.likesCount = 0,
      this.commentsCount = 0,
      this.sharesCount = 0,
      required this.createdAt,
      required this.updatedAt})
      : _imageUrls = imageUrls;
  factory _PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  @override
  final String id;
  @override
  final String authorId;
  @override
  final UserModel author;
  @override
  final String content;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  final String? videoUrl;
  @override
  final String? videoThumbnailUrl;
  @override
  @JsonKey()
  final String mediaType;
  @override
  @JsonKey()
  final int likesCount;
  @override
  @JsonKey()
  final int commentsCount;
  @override
  @JsonKey()
  final int sharesCount;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostModelCopyWith<_PostModel> get copyWith =>
      __$PostModelCopyWithImpl<_PostModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.videoThumbnailUrl, videoThumbnailUrl) ||
                other.videoThumbnailUrl == videoThumbnailUrl) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.sharesCount, sharesCount) ||
                other.sharesCount == sharesCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      author,
      content,
      const DeepCollectionEquality().hash(_imageUrls),
      videoUrl,
      videoThumbnailUrl,
      mediaType,
      likesCount,
      commentsCount,
      sharesCount,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'PostModel(id: $id, authorId: $authorId, author: $author, content: $content, imageUrls: $imageUrls, videoUrl: $videoUrl, videoThumbnailUrl: $videoThumbnailUrl, mediaType: $mediaType, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$PostModelCopyWith<$Res>
    implements $PostModelCopyWith<$Res> {
  factory _$PostModelCopyWith(
          _PostModel value, $Res Function(_PostModel) _then) =
      __$PostModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String authorId,
      UserModel author,
      String content,
      List<String> imageUrls,
      String? videoUrl,
      String? videoThumbnailUrl,
      String mediaType,
      int likesCount,
      int commentsCount,
      int sharesCount,
      String createdAt,
      String updatedAt});

  @override
  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class __$PostModelCopyWithImpl<$Res> implements _$PostModelCopyWith<$Res> {
  __$PostModelCopyWithImpl(this._self, this._then);

  final _PostModel _self;
  final $Res Function(_PostModel) _then;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? author = null,
    Object? content = null,
    Object? imageUrls = null,
    Object? videoUrl = freezed,
    Object? videoThumbnailUrl = freezed,
    Object? mediaType = null,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? sharesCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_PostModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: null == imageUrls
          ? _self._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      videoUrl: freezed == videoUrl
          ? _self.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoThumbnailUrl: freezed == videoThumbnailUrl
          ? _self.videoThumbnailUrl
          : videoThumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaType: null == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      likesCount: null == likesCount
          ? _self.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _self.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      sharesCount: null == sharesCount
          ? _self.sharesCount
          : sharesCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get author {
    return $UserModelCopyWith<$Res>(_self.author, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// @nodoc
mixin _$CommentModel {
  String get id;
  String get postId;
  String get authorId;
  UserModel get author;
  String get content;
  String get createdAt;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommentModelCopyWith<CommentModel> get copyWith =>
      _$CommentModelCopyWithImpl<CommentModel>(
          this as CommentModel, _$identity);

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommentModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, postId, authorId, author, content, createdAt);

  @override
  String toString() {
    return 'CommentModel(id: $id, postId: $postId, authorId: $authorId, author: $author, content: $content, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $CommentModelCopyWith<$Res> {
  factory $CommentModelCopyWith(
          CommentModel value, $Res Function(CommentModel) _then) =
      _$CommentModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String postId,
      String authorId,
      UserModel author,
      String content,
      String createdAt});

  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class _$CommentModelCopyWithImpl<$Res> implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._self, this._then);

  final CommentModel _self;
  final $Res Function(CommentModel) _then;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? authorId = null,
    Object? author = null,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get author {
    return $UserModelCopyWith<$Res>(_self.author, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CommentModel].
extension CommentModelPatterns on CommentModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CommentModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CommentModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CommentModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommentModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CommentModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommentModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String postId, String authorId,
            UserModel author, String content, String createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CommentModel() when $default != null:
        return $default(_that.id, _that.postId, _that.authorId, _that.author,
            _that.content, _that.createdAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String postId, String authorId,
            UserModel author, String content, String createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommentModel():
        return $default(_that.id, _that.postId, _that.authorId, _that.author,
            _that.content, _that.createdAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String postId, String authorId,
            UserModel author, String content, String createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommentModel() when $default != null:
        return $default(_that.id, _that.postId, _that.authorId, _that.author,
            _that.content, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CommentModel implements CommentModel {
  const _CommentModel(
      {required this.id,
      required this.postId,
      required this.authorId,
      required this.author,
      required this.content,
      required this.createdAt});
  factory _CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  @override
  final String id;
  @override
  final String postId;
  @override
  final String authorId;
  @override
  final UserModel author;
  @override
  final String content;
  @override
  final String createdAt;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentModelCopyWith<_CommentModel> get copyWith =>
      __$CommentModelCopyWithImpl<_CommentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CommentModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, postId, authorId, author, content, createdAt);

  @override
  String toString() {
    return 'CommentModel(id: $id, postId: $postId, authorId: $authorId, author: $author, content: $content, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$CommentModelCopyWith<$Res>
    implements $CommentModelCopyWith<$Res> {
  factory _$CommentModelCopyWith(
          _CommentModel value, $Res Function(_CommentModel) _then) =
      __$CommentModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String postId,
      String authorId,
      UserModel author,
      String content,
      String createdAt});

  @override
  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class __$CommentModelCopyWithImpl<$Res>
    implements _$CommentModelCopyWith<$Res> {
  __$CommentModelCopyWithImpl(this._self, this._then);

  final _CommentModel _self;
  final $Res Function(_CommentModel) _then;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? authorId = null,
    Object? author = null,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(_CommentModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get author {
    return $UserModelCopyWith<$Res>(_self.author, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// @nodoc
mixin _$PaginatedPostsResponse {
  List<PostModel> get posts;
  int get total;
  int get page;
  int get totalPages;

  /// Create a copy of PaginatedPostsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginatedPostsResponseCopyWith<PaginatedPostsResponse> get copyWith =>
      _$PaginatedPostsResponseCopyWithImpl<PaginatedPostsResponse>(
          this as PaginatedPostsResponse, _$identity);

  /// Serializes this PaginatedPostsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginatedPostsResponse &&
            const DeepCollectionEquality().equals(other.posts, posts) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(posts), total, page, totalPages);

  @override
  String toString() {
    return 'PaginatedPostsResponse(posts: $posts, total: $total, page: $page, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class $PaginatedPostsResponseCopyWith<$Res> {
  factory $PaginatedPostsResponseCopyWith(PaginatedPostsResponse value,
          $Res Function(PaginatedPostsResponse) _then) =
      _$PaginatedPostsResponseCopyWithImpl;
  @useResult
  $Res call({List<PostModel> posts, int total, int page, int totalPages});
}

/// @nodoc
class _$PaginatedPostsResponseCopyWithImpl<$Res>
    implements $PaginatedPostsResponseCopyWith<$Res> {
  _$PaginatedPostsResponseCopyWithImpl(this._self, this._then);

  final PaginatedPostsResponse _self;
  final $Res Function(PaginatedPostsResponse) _then;

  /// Create a copy of PaginatedPostsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
  }) {
    return _then(_self.copyWith(
      posts: null == posts
          ? _self.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PaginatedPostsResponse].
extension PaginatedPostsResponsePatterns on PaginatedPostsResponse {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PaginatedPostsResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedPostsResponse() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PaginatedPostsResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedPostsResponse():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PaginatedPostsResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedPostsResponse() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<PostModel> posts, int total, int page, int totalPages)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedPostsResponse() when $default != null:
        return $default(_that.posts, _that.total, _that.page, _that.totalPages);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<PostModel> posts, int total, int page, int totalPages)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedPostsResponse():
        return $default(_that.posts, _that.total, _that.page, _that.totalPages);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<PostModel> posts, int total, int page, int totalPages)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedPostsResponse() when $default != null:
        return $default(_that.posts, _that.total, _that.page, _that.totalPages);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PaginatedPostsResponse implements PaginatedPostsResponse {
  const _PaginatedPostsResponse(
      {required final List<PostModel> posts,
      required this.total,
      required this.page,
      required this.totalPages})
      : _posts = posts;
  factory _PaginatedPostsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedPostsResponseFromJson(json);

  final List<PostModel> _posts;
  @override
  List<PostModel> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  final int total;
  @override
  final int page;
  @override
  final int totalPages;

  /// Create a copy of PaginatedPostsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginatedPostsResponseCopyWith<_PaginatedPostsResponse> get copyWith =>
      __$PaginatedPostsResponseCopyWithImpl<_PaginatedPostsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaginatedPostsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginatedPostsResponse &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_posts), total, page, totalPages);

  @override
  String toString() {
    return 'PaginatedPostsResponse(posts: $posts, total: $total, page: $page, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class _$PaginatedPostsResponseCopyWith<$Res>
    implements $PaginatedPostsResponseCopyWith<$Res> {
  factory _$PaginatedPostsResponseCopyWith(_PaginatedPostsResponse value,
          $Res Function(_PaginatedPostsResponse) _then) =
      __$PaginatedPostsResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<PostModel> posts, int total, int page, int totalPages});
}

/// @nodoc
class __$PaginatedPostsResponseCopyWithImpl<$Res>
    implements _$PaginatedPostsResponseCopyWith<$Res> {
  __$PaginatedPostsResponseCopyWithImpl(this._self, this._then);

  final _PaginatedPostsResponse _self;
  final $Res Function(_PaginatedPostsResponse) _then;

  /// Create a copy of PaginatedPostsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? posts = null,
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
  }) {
    return _then(_PaginatedPostsResponse(
      posts: null == posts
          ? _self._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$PaginatedCommentsResponse {
  List<CommentModel> get comments;
  int get total;
  int get page;
  int get totalPages;

  /// Create a copy of PaginatedCommentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginatedCommentsResponseCopyWith<PaginatedCommentsResponse> get copyWith =>
      _$PaginatedCommentsResponseCopyWithImpl<PaginatedCommentsResponse>(
          this as PaginatedCommentsResponse, _$identity);

  /// Serializes this PaginatedCommentsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginatedCommentsResponse &&
            const DeepCollectionEquality().equals(other.comments, comments) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(comments), total, page, totalPages);

  @override
  String toString() {
    return 'PaginatedCommentsResponse(comments: $comments, total: $total, page: $page, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class $PaginatedCommentsResponseCopyWith<$Res> {
  factory $PaginatedCommentsResponseCopyWith(PaginatedCommentsResponse value,
          $Res Function(PaginatedCommentsResponse) _then) =
      _$PaginatedCommentsResponseCopyWithImpl;
  @useResult
  $Res call({List<CommentModel> comments, int total, int page, int totalPages});
}

/// @nodoc
class _$PaginatedCommentsResponseCopyWithImpl<$Res>
    implements $PaginatedCommentsResponseCopyWith<$Res> {
  _$PaginatedCommentsResponseCopyWithImpl(this._self, this._then);

  final PaginatedCommentsResponse _self;
  final $Res Function(PaginatedCommentsResponse) _then;

  /// Create a copy of PaginatedCommentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
  }) {
    return _then(_self.copyWith(
      comments: null == comments
          ? _self.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PaginatedCommentsResponse].
extension PaginatedCommentsResponsePatterns on PaginatedCommentsResponse {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PaginatedCommentsResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommentsResponse() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PaginatedCommentsResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommentsResponse():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PaginatedCommentsResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommentsResponse() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<CommentModel> comments, int total, int page, int totalPages)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommentsResponse() when $default != null:
        return $default(
            _that.comments, _that.total, _that.page, _that.totalPages);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<CommentModel> comments, int total, int page, int totalPages)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommentsResponse():
        return $default(
            _that.comments, _that.total, _that.page, _that.totalPages);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<CommentModel> comments, int total, int page, int totalPages)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommentsResponse() when $default != null:
        return $default(
            _that.comments, _that.total, _that.page, _that.totalPages);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PaginatedCommentsResponse implements PaginatedCommentsResponse {
  const _PaginatedCommentsResponse(
      {required final List<CommentModel> comments,
      required this.total,
      required this.page,
      required this.totalPages})
      : _comments = comments;
  factory _PaginatedCommentsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedCommentsResponseFromJson(json);

  final List<CommentModel> _comments;
  @override
  List<CommentModel> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  final int total;
  @override
  final int page;
  @override
  final int totalPages;

  /// Create a copy of PaginatedCommentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginatedCommentsResponseCopyWith<_PaginatedCommentsResponse>
      get copyWith =>
          __$PaginatedCommentsResponseCopyWithImpl<_PaginatedCommentsResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaginatedCommentsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginatedCommentsResponse &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_comments), total, page, totalPages);

  @override
  String toString() {
    return 'PaginatedCommentsResponse(comments: $comments, total: $total, page: $page, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class _$PaginatedCommentsResponseCopyWith<$Res>
    implements $PaginatedCommentsResponseCopyWith<$Res> {
  factory _$PaginatedCommentsResponseCopyWith(_PaginatedCommentsResponse value,
          $Res Function(_PaginatedCommentsResponse) _then) =
      __$PaginatedCommentsResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<CommentModel> comments, int total, int page, int totalPages});
}

/// @nodoc
class __$PaginatedCommentsResponseCopyWithImpl<$Res>
    implements _$PaginatedCommentsResponseCopyWith<$Res> {
  __$PaginatedCommentsResponseCopyWithImpl(this._self, this._then);

  final _PaginatedCommentsResponse _self;
  final $Res Function(_PaginatedCommentsResponse) _then;

  /// Create a copy of PaginatedCommentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? comments = null,
    Object? total = null,
    Object? page = null,
    Object? totalPages = null,
  }) {
    return _then(_PaginatedCommentsResponse(
      comments: null == comments
          ? _self._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
