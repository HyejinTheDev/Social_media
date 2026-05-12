// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discussion_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiscussionModel {
  String get id;
  String get channelId;
  String get authorId;
  String get content;
  List<String> get imageUrls;
  String? get linkUrl;
  bool get isPinned;
  int get replyCount;
  int get reactionCount;
  AuthorModel? get author;
  String? get createdAt;
  String? get updatedAt;

  /// Create a copy of DiscussionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiscussionModelCopyWith<DiscussionModel> get copyWith =>
      _$DiscussionModelCopyWithImpl<DiscussionModel>(
          this as DiscussionModel, _$identity);

  /// Serializes this DiscussionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DiscussionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other.imageUrls, imageUrls) &&
            (identical(other.linkUrl, linkUrl) || other.linkUrl == linkUrl) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.reactionCount, reactionCount) ||
                other.reactionCount == reactionCount) &&
            (identical(other.author, author) || other.author == author) &&
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
      channelId,
      authorId,
      content,
      const DeepCollectionEquality().hash(imageUrls),
      linkUrl,
      isPinned,
      replyCount,
      reactionCount,
      author,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'DiscussionModel(id: $id, channelId: $channelId, authorId: $authorId, content: $content, imageUrls: $imageUrls, linkUrl: $linkUrl, isPinned: $isPinned, replyCount: $replyCount, reactionCount: $reactionCount, author: $author, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $DiscussionModelCopyWith<$Res> {
  factory $DiscussionModelCopyWith(
          DiscussionModel value, $Res Function(DiscussionModel) _then) =
      _$DiscussionModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String channelId,
      String authorId,
      String content,
      List<String> imageUrls,
      String? linkUrl,
      bool isPinned,
      int replyCount,
      int reactionCount,
      AuthorModel? author,
      String? createdAt,
      String? updatedAt});

  $AuthorModelCopyWith<$Res>? get author;
}

/// @nodoc
class _$DiscussionModelCopyWithImpl<$Res>
    implements $DiscussionModelCopyWith<$Res> {
  _$DiscussionModelCopyWithImpl(this._self, this._then);

  final DiscussionModel _self;
  final $Res Function(DiscussionModel) _then;

  /// Create a copy of DiscussionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channelId = null,
    Object? authorId = null,
    Object? content = null,
    Object? imageUrls = null,
    Object? linkUrl = freezed,
    Object? isPinned = null,
    Object? replyCount = null,
    Object? reactionCount = null,
    Object? author = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      channelId: null == channelId
          ? _self.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: null == imageUrls
          ? _self.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      linkUrl: freezed == linkUrl
          ? _self.linkUrl
          : linkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isPinned: null == isPinned
          ? _self.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      replyCount: null == replyCount
          ? _self.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int,
      reactionCount: null == reactionCount
          ? _self.reactionCount
          : reactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as AuthorModel?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of DiscussionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorModelCopyWith<$Res>? get author {
    if (_self.author == null) {
      return null;
    }

    return $AuthorModelCopyWith<$Res>(_self.author!, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DiscussionModel].
extension DiscussionModelPatterns on DiscussionModel {
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
    TResult Function(_DiscussionModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiscussionModel() when $default != null:
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
    TResult Function(_DiscussionModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscussionModel():
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
    TResult? Function(_DiscussionModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscussionModel() when $default != null:
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
            String channelId,
            String authorId,
            String content,
            List<String> imageUrls,
            String? linkUrl,
            bool isPinned,
            int replyCount,
            int reactionCount,
            AuthorModel? author,
            String? createdAt,
            String? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiscussionModel() when $default != null:
        return $default(
            _that.id,
            _that.channelId,
            _that.authorId,
            _that.content,
            _that.imageUrls,
            _that.linkUrl,
            _that.isPinned,
            _that.replyCount,
            _that.reactionCount,
            _that.author,
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
            String channelId,
            String authorId,
            String content,
            List<String> imageUrls,
            String? linkUrl,
            bool isPinned,
            int replyCount,
            int reactionCount,
            AuthorModel? author,
            String? createdAt,
            String? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscussionModel():
        return $default(
            _that.id,
            _that.channelId,
            _that.authorId,
            _that.content,
            _that.imageUrls,
            _that.linkUrl,
            _that.isPinned,
            _that.replyCount,
            _that.reactionCount,
            _that.author,
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
            String channelId,
            String authorId,
            String content,
            List<String> imageUrls,
            String? linkUrl,
            bool isPinned,
            int replyCount,
            int reactionCount,
            AuthorModel? author,
            String? createdAt,
            String? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscussionModel() when $default != null:
        return $default(
            _that.id,
            _that.channelId,
            _that.authorId,
            _that.content,
            _that.imageUrls,
            _that.linkUrl,
            _that.isPinned,
            _that.replyCount,
            _that.reactionCount,
            _that.author,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DiscussionModel implements DiscussionModel {
  const _DiscussionModel(
      {required this.id,
      required this.channelId,
      required this.authorId,
      required this.content,
      final List<String> imageUrls = const [],
      this.linkUrl,
      this.isPinned = false,
      this.replyCount = 0,
      this.reactionCount = 0,
      this.author,
      this.createdAt,
      this.updatedAt})
      : _imageUrls = imageUrls;
  factory _DiscussionModel.fromJson(Map<String, dynamic> json) =>
      _$DiscussionModelFromJson(json);

  @override
  final String id;
  @override
  final String channelId;
  @override
  final String authorId;
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
  final String? linkUrl;
  @override
  @JsonKey()
  final bool isPinned;
  @override
  @JsonKey()
  final int replyCount;
  @override
  @JsonKey()
  final int reactionCount;
  @override
  final AuthorModel? author;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  /// Create a copy of DiscussionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DiscussionModelCopyWith<_DiscussionModel> get copyWith =>
      __$DiscussionModelCopyWithImpl<_DiscussionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DiscussionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DiscussionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.linkUrl, linkUrl) || other.linkUrl == linkUrl) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.reactionCount, reactionCount) ||
                other.reactionCount == reactionCount) &&
            (identical(other.author, author) || other.author == author) &&
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
      channelId,
      authorId,
      content,
      const DeepCollectionEquality().hash(_imageUrls),
      linkUrl,
      isPinned,
      replyCount,
      reactionCount,
      author,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'DiscussionModel(id: $id, channelId: $channelId, authorId: $authorId, content: $content, imageUrls: $imageUrls, linkUrl: $linkUrl, isPinned: $isPinned, replyCount: $replyCount, reactionCount: $reactionCount, author: $author, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$DiscussionModelCopyWith<$Res>
    implements $DiscussionModelCopyWith<$Res> {
  factory _$DiscussionModelCopyWith(
          _DiscussionModel value, $Res Function(_DiscussionModel) _then) =
      __$DiscussionModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String channelId,
      String authorId,
      String content,
      List<String> imageUrls,
      String? linkUrl,
      bool isPinned,
      int replyCount,
      int reactionCount,
      AuthorModel? author,
      String? createdAt,
      String? updatedAt});

  @override
  $AuthorModelCopyWith<$Res>? get author;
}

/// @nodoc
class __$DiscussionModelCopyWithImpl<$Res>
    implements _$DiscussionModelCopyWith<$Res> {
  __$DiscussionModelCopyWithImpl(this._self, this._then);

  final _DiscussionModel _self;
  final $Res Function(_DiscussionModel) _then;

  /// Create a copy of DiscussionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? channelId = null,
    Object? authorId = null,
    Object? content = null,
    Object? imageUrls = null,
    Object? linkUrl = freezed,
    Object? isPinned = null,
    Object? replyCount = null,
    Object? reactionCount = null,
    Object? author = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_DiscussionModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      channelId: null == channelId
          ? _self.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: null == imageUrls
          ? _self._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      linkUrl: freezed == linkUrl
          ? _self.linkUrl
          : linkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isPinned: null == isPinned
          ? _self.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      replyCount: null == replyCount
          ? _self.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int,
      reactionCount: null == reactionCount
          ? _self.reactionCount
          : reactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as AuthorModel?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of DiscussionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorModelCopyWith<$Res>? get author {
    if (_self.author == null) {
      return null;
    }

    return $AuthorModelCopyWith<$Res>(_self.author!, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// @nodoc
mixin _$ReplyModel {
  String get id;
  String get discussionId;
  String? get parentId;
  String get authorId;
  String get content;
  AuthorModel? get author;
  List<ReplyModel> get children;
  String? get createdAt;

  /// Create a copy of ReplyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReplyModelCopyWith<ReplyModel> get copyWith =>
      _$ReplyModelCopyWithImpl<ReplyModel>(this as ReplyModel, _$identity);

  /// Serializes this ReplyModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReplyModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.discussionId, discussionId) ||
                other.discussionId == discussionId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality().equals(other.children, children) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      discussionId,
      parentId,
      authorId,
      content,
      author,
      const DeepCollectionEquality().hash(children),
      createdAt);

  @override
  String toString() {
    return 'ReplyModel(id: $id, discussionId: $discussionId, parentId: $parentId, authorId: $authorId, content: $content, author: $author, children: $children, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $ReplyModelCopyWith<$Res> {
  factory $ReplyModelCopyWith(
          ReplyModel value, $Res Function(ReplyModel) _then) =
      _$ReplyModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String discussionId,
      String? parentId,
      String authorId,
      String content,
      AuthorModel? author,
      List<ReplyModel> children,
      String? createdAt});

  $AuthorModelCopyWith<$Res>? get author;
}

/// @nodoc
class _$ReplyModelCopyWithImpl<$Res> implements $ReplyModelCopyWith<$Res> {
  _$ReplyModelCopyWithImpl(this._self, this._then);

  final ReplyModel _self;
  final $Res Function(ReplyModel) _then;

  /// Create a copy of ReplyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? discussionId = null,
    Object? parentId = freezed,
    Object? authorId = null,
    Object? content = null,
    Object? author = freezed,
    Object? children = null,
    Object? createdAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      discussionId: null == discussionId
          ? _self.discussionId
          : discussionId // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _self.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as AuthorModel?,
      children: null == children
          ? _self.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ReplyModel>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ReplyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorModelCopyWith<$Res>? get author {
    if (_self.author == null) {
      return null;
    }

    return $AuthorModelCopyWith<$Res>(_self.author!, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ReplyModel].
extension ReplyModelPatterns on ReplyModel {
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
    TResult Function(_ReplyModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReplyModel() when $default != null:
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
    TResult Function(_ReplyModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReplyModel():
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
    TResult? Function(_ReplyModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReplyModel() when $default != null:
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
            String discussionId,
            String? parentId,
            String authorId,
            String content,
            AuthorModel? author,
            List<ReplyModel> children,
            String? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReplyModel() when $default != null:
        return $default(
            _that.id,
            _that.discussionId,
            _that.parentId,
            _that.authorId,
            _that.content,
            _that.author,
            _that.children,
            _that.createdAt);
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
            String discussionId,
            String? parentId,
            String authorId,
            String content,
            AuthorModel? author,
            List<ReplyModel> children,
            String? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReplyModel():
        return $default(
            _that.id,
            _that.discussionId,
            _that.parentId,
            _that.authorId,
            _that.content,
            _that.author,
            _that.children,
            _that.createdAt);
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
            String discussionId,
            String? parentId,
            String authorId,
            String content,
            AuthorModel? author,
            List<ReplyModel> children,
            String? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReplyModel() when $default != null:
        return $default(
            _that.id,
            _that.discussionId,
            _that.parentId,
            _that.authorId,
            _that.content,
            _that.author,
            _that.children,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReplyModel implements ReplyModel {
  const _ReplyModel(
      {required this.id,
      required this.discussionId,
      this.parentId,
      required this.authorId,
      required this.content,
      this.author,
      final List<ReplyModel> children = const [],
      this.createdAt})
      : _children = children;
  factory _ReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyModelFromJson(json);

  @override
  final String id;
  @override
  final String discussionId;
  @override
  final String? parentId;
  @override
  final String authorId;
  @override
  final String content;
  @override
  final AuthorModel? author;
  final List<ReplyModel> _children;
  @override
  @JsonKey()
  List<ReplyModel> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  final String? createdAt;

  /// Create a copy of ReplyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReplyModelCopyWith<_ReplyModel> get copyWith =>
      __$ReplyModelCopyWithImpl<_ReplyModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReplyModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReplyModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.discussionId, discussionId) ||
                other.discussionId == discussionId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      discussionId,
      parentId,
      authorId,
      content,
      author,
      const DeepCollectionEquality().hash(_children),
      createdAt);

  @override
  String toString() {
    return 'ReplyModel(id: $id, discussionId: $discussionId, parentId: $parentId, authorId: $authorId, content: $content, author: $author, children: $children, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$ReplyModelCopyWith<$Res>
    implements $ReplyModelCopyWith<$Res> {
  factory _$ReplyModelCopyWith(
          _ReplyModel value, $Res Function(_ReplyModel) _then) =
      __$ReplyModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String discussionId,
      String? parentId,
      String authorId,
      String content,
      AuthorModel? author,
      List<ReplyModel> children,
      String? createdAt});

  @override
  $AuthorModelCopyWith<$Res>? get author;
}

/// @nodoc
class __$ReplyModelCopyWithImpl<$Res> implements _$ReplyModelCopyWith<$Res> {
  __$ReplyModelCopyWithImpl(this._self, this._then);

  final _ReplyModel _self;
  final $Res Function(_ReplyModel) _then;

  /// Create a copy of ReplyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? discussionId = null,
    Object? parentId = freezed,
    Object? authorId = null,
    Object? content = null,
    Object? author = freezed,
    Object? children = null,
    Object? createdAt = freezed,
  }) {
    return _then(_ReplyModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      discussionId: null == discussionId
          ? _self.discussionId
          : discussionId // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _self.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as AuthorModel?,
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ReplyModel>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ReplyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorModelCopyWith<$Res>? get author {
    if (_self.author == null) {
      return null;
    }

    return $AuthorModelCopyWith<$Res>(_self.author!, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// @nodoc
mixin _$AuthorModel {
  String get id;
  String get name;
  String get username;
  String? get avatar;

  /// Create a copy of AuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthorModelCopyWith<AuthorModel> get copyWith =>
      _$AuthorModelCopyWithImpl<AuthorModel>(this as AuthorModel, _$identity);

  /// Serializes this AuthorModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthorModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, username, avatar);

  @override
  String toString() {
    return 'AuthorModel(id: $id, name: $name, username: $username, avatar: $avatar)';
  }
}

/// @nodoc
abstract mixin class $AuthorModelCopyWith<$Res> {
  factory $AuthorModelCopyWith(
          AuthorModel value, $Res Function(AuthorModel) _then) =
      _$AuthorModelCopyWithImpl;
  @useResult
  $Res call({String id, String name, String username, String? avatar});
}

/// @nodoc
class _$AuthorModelCopyWithImpl<$Res> implements $AuthorModelCopyWith<$Res> {
  _$AuthorModelCopyWithImpl(this._self, this._then);

  final AuthorModel _self;
  final $Res Function(AuthorModel) _then;

  /// Create a copy of AuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? username = null,
    Object? avatar = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AuthorModel].
extension AuthorModelPatterns on AuthorModel {
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
    TResult Function(_AuthorModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthorModel() when $default != null:
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
    TResult Function(_AuthorModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthorModel():
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
    TResult? Function(_AuthorModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthorModel() when $default != null:
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
    TResult Function(String id, String name, String username, String? avatar)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthorModel() when $default != null:
        return $default(_that.id, _that.name, _that.username, _that.avatar);
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
    TResult Function(String id, String name, String username, String? avatar)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthorModel():
        return $default(_that.id, _that.name, _that.username, _that.avatar);
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
    TResult? Function(String id, String name, String username, String? avatar)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthorModel() when $default != null:
        return $default(_that.id, _that.name, _that.username, _that.avatar);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AuthorModel implements AuthorModel {
  const _AuthorModel(
      {required this.id,
      required this.name,
      required this.username,
      this.avatar});
  factory _AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String username;
  @override
  final String? avatar;

  /// Create a copy of AuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthorModelCopyWith<_AuthorModel> get copyWith =>
      __$AuthorModelCopyWithImpl<_AuthorModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuthorModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthorModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, username, avatar);

  @override
  String toString() {
    return 'AuthorModel(id: $id, name: $name, username: $username, avatar: $avatar)';
  }
}

/// @nodoc
abstract mixin class _$AuthorModelCopyWith<$Res>
    implements $AuthorModelCopyWith<$Res> {
  factory _$AuthorModelCopyWith(
          _AuthorModel value, $Res Function(_AuthorModel) _then) =
      __$AuthorModelCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name, String username, String? avatar});
}

/// @nodoc
class __$AuthorModelCopyWithImpl<$Res> implements _$AuthorModelCopyWith<$Res> {
  __$AuthorModelCopyWithImpl(this._self, this._then);

  final _AuthorModel _self;
  final $Res Function(_AuthorModel) _then;

  /// Create a copy of AuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? username = null,
    Object? avatar = freezed,
  }) {
    return _then(_AuthorModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$PaginatedDiscussionsResponse {
  List<DiscussionModel> get discussions;
  int get total;

  /// Create a copy of PaginatedDiscussionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginatedDiscussionsResponseCopyWith<PaginatedDiscussionsResponse>
      get copyWith => _$PaginatedDiscussionsResponseCopyWithImpl<
              PaginatedDiscussionsResponse>(
          this as PaginatedDiscussionsResponse, _$identity);

  /// Serializes this PaginatedDiscussionsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginatedDiscussionsResponse &&
            const DeepCollectionEquality()
                .equals(other.discussions, discussions) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(discussions), total);

  @override
  String toString() {
    return 'PaginatedDiscussionsResponse(discussions: $discussions, total: $total)';
  }
}

/// @nodoc
abstract mixin class $PaginatedDiscussionsResponseCopyWith<$Res> {
  factory $PaginatedDiscussionsResponseCopyWith(
          PaginatedDiscussionsResponse value,
          $Res Function(PaginatedDiscussionsResponse) _then) =
      _$PaginatedDiscussionsResponseCopyWithImpl;
  @useResult
  $Res call({List<DiscussionModel> discussions, int total});
}

/// @nodoc
class _$PaginatedDiscussionsResponseCopyWithImpl<$Res>
    implements $PaginatedDiscussionsResponseCopyWith<$Res> {
  _$PaginatedDiscussionsResponseCopyWithImpl(this._self, this._then);

  final PaginatedDiscussionsResponse _self;
  final $Res Function(PaginatedDiscussionsResponse) _then;

  /// Create a copy of PaginatedDiscussionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discussions = null,
    Object? total = null,
  }) {
    return _then(_self.copyWith(
      discussions: null == discussions
          ? _self.discussions
          : discussions // ignore: cast_nullable_to_non_nullable
              as List<DiscussionModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PaginatedDiscussionsResponse].
extension PaginatedDiscussionsResponsePatterns on PaginatedDiscussionsResponse {
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
    TResult Function(_PaginatedDiscussionsResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedDiscussionsResponse() when $default != null:
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
    TResult Function(_PaginatedDiscussionsResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedDiscussionsResponse():
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
    TResult? Function(_PaginatedDiscussionsResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedDiscussionsResponse() when $default != null:
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
    TResult Function(List<DiscussionModel> discussions, int total)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedDiscussionsResponse() when $default != null:
        return $default(_that.discussions, _that.total);
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
    TResult Function(List<DiscussionModel> discussions, int total) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedDiscussionsResponse():
        return $default(_that.discussions, _that.total);
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
    TResult? Function(List<DiscussionModel> discussions, int total)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedDiscussionsResponse() when $default != null:
        return $default(_that.discussions, _that.total);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PaginatedDiscussionsResponse implements PaginatedDiscussionsResponse {
  const _PaginatedDiscussionsResponse(
      {required final List<DiscussionModel> discussions, required this.total})
      : _discussions = discussions;
  factory _PaginatedDiscussionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedDiscussionsResponseFromJson(json);

  final List<DiscussionModel> _discussions;
  @override
  List<DiscussionModel> get discussions {
    if (_discussions is EqualUnmodifiableListView) return _discussions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_discussions);
  }

  @override
  final int total;

  /// Create a copy of PaginatedDiscussionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginatedDiscussionsResponseCopyWith<_PaginatedDiscussionsResponse>
      get copyWith => __$PaginatedDiscussionsResponseCopyWithImpl<
          _PaginatedDiscussionsResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaginatedDiscussionsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginatedDiscussionsResponse &&
            const DeepCollectionEquality()
                .equals(other._discussions, _discussions) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_discussions), total);

  @override
  String toString() {
    return 'PaginatedDiscussionsResponse(discussions: $discussions, total: $total)';
  }
}

/// @nodoc
abstract mixin class _$PaginatedDiscussionsResponseCopyWith<$Res>
    implements $PaginatedDiscussionsResponseCopyWith<$Res> {
  factory _$PaginatedDiscussionsResponseCopyWith(
          _PaginatedDiscussionsResponse value,
          $Res Function(_PaginatedDiscussionsResponse) _then) =
      __$PaginatedDiscussionsResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<DiscussionModel> discussions, int total});
}

/// @nodoc
class __$PaginatedDiscussionsResponseCopyWithImpl<$Res>
    implements _$PaginatedDiscussionsResponseCopyWith<$Res> {
  __$PaginatedDiscussionsResponseCopyWithImpl(this._self, this._then);

  final _PaginatedDiscussionsResponse _self;
  final $Res Function(_PaginatedDiscussionsResponse) _then;

  /// Create a copy of PaginatedDiscussionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? discussions = null,
    Object? total = null,
  }) {
    return _then(_PaginatedDiscussionsResponse(
      discussions: null == discussions
          ? _self._discussions
          : discussions // ignore: cast_nullable_to_non_nullable
              as List<DiscussionModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
