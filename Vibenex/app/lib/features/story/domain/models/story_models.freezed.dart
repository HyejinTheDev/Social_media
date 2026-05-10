// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoryModel {
  String get id;
  String get authorId;
  UserModel get author;
  String get mediaUrl;
  String get mediaType;
  String? get caption;
  int get viewCount;
  String get expiresAt;
  String get createdAt;
  bool get isViewed;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoryModelCopyWith<StoryModel> get copyWith =>
      _$StoryModelCopyWithImpl<StoryModel>(this as StoryModel, _$identity);

  /// Serializes this StoryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isViewed, isViewed) ||
                other.isViewed == isViewed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, authorId, author, mediaUrl,
      mediaType, caption, viewCount, expiresAt, createdAt, isViewed);

  @override
  String toString() {
    return 'StoryModel(id: $id, authorId: $authorId, author: $author, mediaUrl: $mediaUrl, mediaType: $mediaType, caption: $caption, viewCount: $viewCount, expiresAt: $expiresAt, createdAt: $createdAt, isViewed: $isViewed)';
  }
}

/// @nodoc
abstract mixin class $StoryModelCopyWith<$Res> {
  factory $StoryModelCopyWith(
          StoryModel value, $Res Function(StoryModel) _then) =
      _$StoryModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String authorId,
      UserModel author,
      String mediaUrl,
      String mediaType,
      String? caption,
      int viewCount,
      String expiresAt,
      String createdAt,
      bool isViewed});

  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class _$StoryModelCopyWithImpl<$Res> implements $StoryModelCopyWith<$Res> {
  _$StoryModelCopyWithImpl(this._self, this._then);

  final StoryModel _self;
  final $Res Function(StoryModel) _then;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? author = null,
    Object? mediaUrl = null,
    Object? mediaType = null,
    Object? caption = freezed,
    Object? viewCount = null,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? isViewed = null,
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
      mediaUrl: null == mediaUrl
          ? _self.mediaUrl
          : mediaUrl // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      viewCount: null == viewCount
          ? _self.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      isViewed: null == isViewed
          ? _self.isViewed
          : isViewed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get author {
    return $UserModelCopyWith<$Res>(_self.author, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// Adds pattern-matching-related methods to [StoryModel].
extension StoryModelPatterns on StoryModel {
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
    TResult Function(_StoryModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoryModel() when $default != null:
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
    TResult Function(_StoryModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryModel():
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
    TResult? Function(_StoryModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryModel() when $default != null:
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
            String mediaUrl,
            String mediaType,
            String? caption,
            int viewCount,
            String expiresAt,
            String createdAt,
            bool isViewed)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoryModel() when $default != null:
        return $default(
            _that.id,
            _that.authorId,
            _that.author,
            _that.mediaUrl,
            _that.mediaType,
            _that.caption,
            _that.viewCount,
            _that.expiresAt,
            _that.createdAt,
            _that.isViewed);
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
            String mediaUrl,
            String mediaType,
            String? caption,
            int viewCount,
            String expiresAt,
            String createdAt,
            bool isViewed)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryModel():
        return $default(
            _that.id,
            _that.authorId,
            _that.author,
            _that.mediaUrl,
            _that.mediaType,
            _that.caption,
            _that.viewCount,
            _that.expiresAt,
            _that.createdAt,
            _that.isViewed);
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
            String mediaUrl,
            String mediaType,
            String? caption,
            int viewCount,
            String expiresAt,
            String createdAt,
            bool isViewed)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryModel() when $default != null:
        return $default(
            _that.id,
            _that.authorId,
            _that.author,
            _that.mediaUrl,
            _that.mediaType,
            _that.caption,
            _that.viewCount,
            _that.expiresAt,
            _that.createdAt,
            _that.isViewed);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StoryModel implements StoryModel {
  const _StoryModel(
      {required this.id,
      required this.authorId,
      required this.author,
      required this.mediaUrl,
      this.mediaType = 'IMAGE',
      this.caption,
      this.viewCount = 0,
      required this.expiresAt,
      required this.createdAt,
      this.isViewed = false});
  factory _StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  @override
  final String id;
  @override
  final String authorId;
  @override
  final UserModel author;
  @override
  final String mediaUrl;
  @override
  @JsonKey()
  final String mediaType;
  @override
  final String? caption;
  @override
  @JsonKey()
  final int viewCount;
  @override
  final String expiresAt;
  @override
  final String createdAt;
  @override
  @JsonKey()
  final bool isViewed;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoryModelCopyWith<_StoryModel> get copyWith =>
      __$StoryModelCopyWithImpl<_StoryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isViewed, isViewed) ||
                other.isViewed == isViewed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, authorId, author, mediaUrl,
      mediaType, caption, viewCount, expiresAt, createdAt, isViewed);

  @override
  String toString() {
    return 'StoryModel(id: $id, authorId: $authorId, author: $author, mediaUrl: $mediaUrl, mediaType: $mediaType, caption: $caption, viewCount: $viewCount, expiresAt: $expiresAt, createdAt: $createdAt, isViewed: $isViewed)';
  }
}

/// @nodoc
abstract mixin class _$StoryModelCopyWith<$Res>
    implements $StoryModelCopyWith<$Res> {
  factory _$StoryModelCopyWith(
          _StoryModel value, $Res Function(_StoryModel) _then) =
      __$StoryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String authorId,
      UserModel author,
      String mediaUrl,
      String mediaType,
      String? caption,
      int viewCount,
      String expiresAt,
      String createdAt,
      bool isViewed});

  @override
  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class __$StoryModelCopyWithImpl<$Res> implements _$StoryModelCopyWith<$Res> {
  __$StoryModelCopyWithImpl(this._self, this._then);

  final _StoryModel _self;
  final $Res Function(_StoryModel) _then;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? author = null,
    Object? mediaUrl = null,
    Object? mediaType = null,
    Object? caption = freezed,
    Object? viewCount = null,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? isViewed = null,
  }) {
    return _then(_StoryModel(
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
      mediaUrl: null == mediaUrl
          ? _self.mediaUrl
          : mediaUrl // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      viewCount: null == viewCount
          ? _self.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      isViewed: null == isViewed
          ? _self.isViewed
          : isViewed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of StoryModel
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
mixin _$StoryGroup {
  UserModel get author;
  List<StoryModel> get stories;
  bool get hasUnviewed;

  /// Create a copy of StoryGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoryGroupCopyWith<StoryGroup> get copyWith =>
      _$StoryGroupCopyWithImpl<StoryGroup>(this as StoryGroup, _$identity);

  /// Serializes this StoryGroup to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoryGroup &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality().equals(other.stories, stories) &&
            (identical(other.hasUnviewed, hasUnviewed) ||
                other.hasUnviewed == hasUnviewed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, author,
      const DeepCollectionEquality().hash(stories), hasUnviewed);

  @override
  String toString() {
    return 'StoryGroup(author: $author, stories: $stories, hasUnviewed: $hasUnviewed)';
  }
}

/// @nodoc
abstract mixin class $StoryGroupCopyWith<$Res> {
  factory $StoryGroupCopyWith(
          StoryGroup value, $Res Function(StoryGroup) _then) =
      _$StoryGroupCopyWithImpl;
  @useResult
  $Res call({UserModel author, List<StoryModel> stories, bool hasUnviewed});

  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class _$StoryGroupCopyWithImpl<$Res> implements $StoryGroupCopyWith<$Res> {
  _$StoryGroupCopyWithImpl(this._self, this._then);

  final StoryGroup _self;
  final $Res Function(StoryGroup) _then;

  /// Create a copy of StoryGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? stories = null,
    Object? hasUnviewed = null,
  }) {
    return _then(_self.copyWith(
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      stories: null == stories
          ? _self.stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<StoryModel>,
      hasUnviewed: null == hasUnviewed
          ? _self.hasUnviewed
          : hasUnviewed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of StoryGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get author {
    return $UserModelCopyWith<$Res>(_self.author, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// Adds pattern-matching-related methods to [StoryGroup].
extension StoryGroupPatterns on StoryGroup {
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
    TResult Function(_StoryGroup value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoryGroup() when $default != null:
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
    TResult Function(_StoryGroup value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryGroup():
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
    TResult? Function(_StoryGroup value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryGroup() when $default != null:
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
            UserModel author, List<StoryModel> stories, bool hasUnviewed)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoryGroup() when $default != null:
        return $default(_that.author, _that.stories, _that.hasUnviewed);
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
            UserModel author, List<StoryModel> stories, bool hasUnviewed)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryGroup():
        return $default(_that.author, _that.stories, _that.hasUnviewed);
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
            UserModel author, List<StoryModel> stories, bool hasUnviewed)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryGroup() when $default != null:
        return $default(_that.author, _that.stories, _that.hasUnviewed);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StoryGroup implements StoryGroup {
  const _StoryGroup(
      {required this.author,
      required final List<StoryModel> stories,
      this.hasUnviewed = false})
      : _stories = stories;
  factory _StoryGroup.fromJson(Map<String, dynamic> json) =>
      _$StoryGroupFromJson(json);

  @override
  final UserModel author;
  final List<StoryModel> _stories;
  @override
  List<StoryModel> get stories {
    if (_stories is EqualUnmodifiableListView) return _stories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stories);
  }

  @override
  @JsonKey()
  final bool hasUnviewed;

  /// Create a copy of StoryGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoryGroupCopyWith<_StoryGroup> get copyWith =>
      __$StoryGroupCopyWithImpl<_StoryGroup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoryGroupToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoryGroup &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality().equals(other._stories, _stories) &&
            (identical(other.hasUnviewed, hasUnviewed) ||
                other.hasUnviewed == hasUnviewed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, author,
      const DeepCollectionEquality().hash(_stories), hasUnviewed);

  @override
  String toString() {
    return 'StoryGroup(author: $author, stories: $stories, hasUnviewed: $hasUnviewed)';
  }
}

/// @nodoc
abstract mixin class _$StoryGroupCopyWith<$Res>
    implements $StoryGroupCopyWith<$Res> {
  factory _$StoryGroupCopyWith(
          _StoryGroup value, $Res Function(_StoryGroup) _then) =
      __$StoryGroupCopyWithImpl;
  @override
  @useResult
  $Res call({UserModel author, List<StoryModel> stories, bool hasUnviewed});

  @override
  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class __$StoryGroupCopyWithImpl<$Res> implements _$StoryGroupCopyWith<$Res> {
  __$StoryGroupCopyWithImpl(this._self, this._then);

  final _StoryGroup _self;
  final $Res Function(_StoryGroup) _then;

  /// Create a copy of StoryGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? author = null,
    Object? stories = null,
    Object? hasUnviewed = null,
  }) {
    return _then(_StoryGroup(
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      stories: null == stories
          ? _self._stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<StoryModel>,
      hasUnviewed: null == hasUnviewed
          ? _self.hasUnviewed
          : hasUnviewed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of StoryGroup
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
mixin _$StoryGroupsResponse {
  List<StoryGroup> get groups;

  /// Create a copy of StoryGroupsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoryGroupsResponseCopyWith<StoryGroupsResponse> get copyWith =>
      _$StoryGroupsResponseCopyWithImpl<StoryGroupsResponse>(
          this as StoryGroupsResponse, _$identity);

  /// Serializes this StoryGroupsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoryGroupsResponse &&
            const DeepCollectionEquality().equals(other.groups, groups));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(groups));

  @override
  String toString() {
    return 'StoryGroupsResponse(groups: $groups)';
  }
}

/// @nodoc
abstract mixin class $StoryGroupsResponseCopyWith<$Res> {
  factory $StoryGroupsResponseCopyWith(
          StoryGroupsResponse value, $Res Function(StoryGroupsResponse) _then) =
      _$StoryGroupsResponseCopyWithImpl;
  @useResult
  $Res call({List<StoryGroup> groups});
}

/// @nodoc
class _$StoryGroupsResponseCopyWithImpl<$Res>
    implements $StoryGroupsResponseCopyWith<$Res> {
  _$StoryGroupsResponseCopyWithImpl(this._self, this._then);

  final StoryGroupsResponse _self;
  final $Res Function(StoryGroupsResponse) _then;

  /// Create a copy of StoryGroupsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groups = null,
  }) {
    return _then(_self.copyWith(
      groups: null == groups
          ? _self.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<StoryGroup>,
    ));
  }
}

/// Adds pattern-matching-related methods to [StoryGroupsResponse].
extension StoryGroupsResponsePatterns on StoryGroupsResponse {
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
    TResult Function(_StoryGroupsResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoryGroupsResponse() when $default != null:
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
    TResult Function(_StoryGroupsResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryGroupsResponse():
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
    TResult? Function(_StoryGroupsResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryGroupsResponse() when $default != null:
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
    TResult Function(List<StoryGroup> groups)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoryGroupsResponse() when $default != null:
        return $default(_that.groups);
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
    TResult Function(List<StoryGroup> groups) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryGroupsResponse():
        return $default(_that.groups);
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
    TResult? Function(List<StoryGroup> groups)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryGroupsResponse() when $default != null:
        return $default(_that.groups);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StoryGroupsResponse implements StoryGroupsResponse {
  const _StoryGroupsResponse({required final List<StoryGroup> groups})
      : _groups = groups;
  factory _StoryGroupsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryGroupsResponseFromJson(json);

  final List<StoryGroup> _groups;
  @override
  List<StoryGroup> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  /// Create a copy of StoryGroupsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoryGroupsResponseCopyWith<_StoryGroupsResponse> get copyWith =>
      __$StoryGroupsResponseCopyWithImpl<_StoryGroupsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoryGroupsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoryGroupsResponse &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_groups));

  @override
  String toString() {
    return 'StoryGroupsResponse(groups: $groups)';
  }
}

/// @nodoc
abstract mixin class _$StoryGroupsResponseCopyWith<$Res>
    implements $StoryGroupsResponseCopyWith<$Res> {
  factory _$StoryGroupsResponseCopyWith(_StoryGroupsResponse value,
          $Res Function(_StoryGroupsResponse) _then) =
      __$StoryGroupsResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<StoryGroup> groups});
}

/// @nodoc
class __$StoryGroupsResponseCopyWithImpl<$Res>
    implements _$StoryGroupsResponseCopyWith<$Res> {
  __$StoryGroupsResponseCopyWithImpl(this._self, this._then);

  final _StoryGroupsResponse _self;
  final $Res Function(_StoryGroupsResponse) _then;

  /// Create a copy of StoryGroupsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? groups = null,
  }) {
    return _then(_StoryGroupsResponse(
      groups: null == groups
          ? _self._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<StoryGroup>,
    ));
  }
}

/// @nodoc
mixin _$StoryViewerModel {
  String get id;
  String get viewerId;
  UserModel get viewer;
  String get viewedAt;

  /// Create a copy of StoryViewerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoryViewerModelCopyWith<StoryViewerModel> get copyWith =>
      _$StoryViewerModelCopyWithImpl<StoryViewerModel>(
          this as StoryViewerModel, _$identity);

  /// Serializes this StoryViewerModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoryViewerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.viewerId, viewerId) ||
                other.viewerId == viewerId) &&
            (identical(other.viewer, viewer) || other.viewer == viewer) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, viewerId, viewer, viewedAt);

  @override
  String toString() {
    return 'StoryViewerModel(id: $id, viewerId: $viewerId, viewer: $viewer, viewedAt: $viewedAt)';
  }
}

/// @nodoc
abstract mixin class $StoryViewerModelCopyWith<$Res> {
  factory $StoryViewerModelCopyWith(
          StoryViewerModel value, $Res Function(StoryViewerModel) _then) =
      _$StoryViewerModelCopyWithImpl;
  @useResult
  $Res call({String id, String viewerId, UserModel viewer, String viewedAt});

  $UserModelCopyWith<$Res> get viewer;
}

/// @nodoc
class _$StoryViewerModelCopyWithImpl<$Res>
    implements $StoryViewerModelCopyWith<$Res> {
  _$StoryViewerModelCopyWithImpl(this._self, this._then);

  final StoryViewerModel _self;
  final $Res Function(StoryViewerModel) _then;

  /// Create a copy of StoryViewerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? viewerId = null,
    Object? viewer = null,
    Object? viewedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      viewerId: null == viewerId
          ? _self.viewerId
          : viewerId // ignore: cast_nullable_to_non_nullable
              as String,
      viewer: null == viewer
          ? _self.viewer
          : viewer // ignore: cast_nullable_to_non_nullable
              as UserModel,
      viewedAt: null == viewedAt
          ? _self.viewedAt
          : viewedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of StoryViewerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get viewer {
    return $UserModelCopyWith<$Res>(_self.viewer, (value) {
      return _then(_self.copyWith(viewer: value));
    });
  }
}

/// Adds pattern-matching-related methods to [StoryViewerModel].
extension StoryViewerModelPatterns on StoryViewerModel {
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
    TResult Function(_StoryViewerModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoryViewerModel() when $default != null:
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
    TResult Function(_StoryViewerModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryViewerModel():
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
    TResult? Function(_StoryViewerModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryViewerModel() when $default != null:
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
            String id, String viewerId, UserModel viewer, String viewedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoryViewerModel() when $default != null:
        return $default(_that.id, _that.viewerId, _that.viewer, _that.viewedAt);
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
            String id, String viewerId, UserModel viewer, String viewedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryViewerModel():
        return $default(_that.id, _that.viewerId, _that.viewer, _that.viewedAt);
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
            String id, String viewerId, UserModel viewer, String viewedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoryViewerModel() when $default != null:
        return $default(_that.id, _that.viewerId, _that.viewer, _that.viewedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StoryViewerModel implements StoryViewerModel {
  const _StoryViewerModel(
      {required this.id,
      required this.viewerId,
      required this.viewer,
      required this.viewedAt});
  factory _StoryViewerModel.fromJson(Map<String, dynamic> json) =>
      _$StoryViewerModelFromJson(json);

  @override
  final String id;
  @override
  final String viewerId;
  @override
  final UserModel viewer;
  @override
  final String viewedAt;

  /// Create a copy of StoryViewerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoryViewerModelCopyWith<_StoryViewerModel> get copyWith =>
      __$StoryViewerModelCopyWithImpl<_StoryViewerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoryViewerModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoryViewerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.viewerId, viewerId) ||
                other.viewerId == viewerId) &&
            (identical(other.viewer, viewer) || other.viewer == viewer) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, viewerId, viewer, viewedAt);

  @override
  String toString() {
    return 'StoryViewerModel(id: $id, viewerId: $viewerId, viewer: $viewer, viewedAt: $viewedAt)';
  }
}

/// @nodoc
abstract mixin class _$StoryViewerModelCopyWith<$Res>
    implements $StoryViewerModelCopyWith<$Res> {
  factory _$StoryViewerModelCopyWith(
          _StoryViewerModel value, $Res Function(_StoryViewerModel) _then) =
      __$StoryViewerModelCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String viewerId, UserModel viewer, String viewedAt});

  @override
  $UserModelCopyWith<$Res> get viewer;
}

/// @nodoc
class __$StoryViewerModelCopyWithImpl<$Res>
    implements _$StoryViewerModelCopyWith<$Res> {
  __$StoryViewerModelCopyWithImpl(this._self, this._then);

  final _StoryViewerModel _self;
  final $Res Function(_StoryViewerModel) _then;

  /// Create a copy of StoryViewerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? viewerId = null,
    Object? viewer = null,
    Object? viewedAt = null,
  }) {
    return _then(_StoryViewerModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      viewerId: null == viewerId
          ? _self.viewerId
          : viewerId // ignore: cast_nullable_to_non_nullable
              as String,
      viewer: null == viewer
          ? _self.viewer
          : viewer // ignore: cast_nullable_to_non_nullable
              as UserModel,
      viewedAt: null == viewedAt
          ? _self.viewedAt
          : viewedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of StoryViewerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get viewer {
    return $UserModelCopyWith<$Res>(_self.viewer, (value) {
      return _then(_self.copyWith(viewer: value));
    });
  }
}

/// @nodoc
mixin _$MyStoriesResponse {
  List<MyStoryDetail> get stories;

  /// Create a copy of MyStoriesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MyStoriesResponseCopyWith<MyStoriesResponse> get copyWith =>
      _$MyStoriesResponseCopyWithImpl<MyStoriesResponse>(
          this as MyStoriesResponse, _$identity);

  /// Serializes this MyStoriesResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyStoriesResponse &&
            const DeepCollectionEquality().equals(other.stories, stories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(stories));

  @override
  String toString() {
    return 'MyStoriesResponse(stories: $stories)';
  }
}

/// @nodoc
abstract mixin class $MyStoriesResponseCopyWith<$Res> {
  factory $MyStoriesResponseCopyWith(
          MyStoriesResponse value, $Res Function(MyStoriesResponse) _then) =
      _$MyStoriesResponseCopyWithImpl;
  @useResult
  $Res call({List<MyStoryDetail> stories});
}

/// @nodoc
class _$MyStoriesResponseCopyWithImpl<$Res>
    implements $MyStoriesResponseCopyWith<$Res> {
  _$MyStoriesResponseCopyWithImpl(this._self, this._then);

  final MyStoriesResponse _self;
  final $Res Function(MyStoriesResponse) _then;

  /// Create a copy of MyStoriesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stories = null,
  }) {
    return _then(_self.copyWith(
      stories: null == stories
          ? _self.stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<MyStoryDetail>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MyStoriesResponse].
extension MyStoriesResponsePatterns on MyStoriesResponse {
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
    TResult Function(_MyStoriesResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MyStoriesResponse() when $default != null:
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
    TResult Function(_MyStoriesResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MyStoriesResponse():
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
    TResult? Function(_MyStoriesResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MyStoriesResponse() when $default != null:
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
    TResult Function(List<MyStoryDetail> stories)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MyStoriesResponse() when $default != null:
        return $default(_that.stories);
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
    TResult Function(List<MyStoryDetail> stories) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MyStoriesResponse():
        return $default(_that.stories);
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
    TResult? Function(List<MyStoryDetail> stories)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MyStoriesResponse() when $default != null:
        return $default(_that.stories);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MyStoriesResponse implements MyStoriesResponse {
  const _MyStoriesResponse({required final List<MyStoryDetail> stories})
      : _stories = stories;
  factory _MyStoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$MyStoriesResponseFromJson(json);

  final List<MyStoryDetail> _stories;
  @override
  List<MyStoryDetail> get stories {
    if (_stories is EqualUnmodifiableListView) return _stories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stories);
  }

  /// Create a copy of MyStoriesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MyStoriesResponseCopyWith<_MyStoriesResponse> get copyWith =>
      __$MyStoriesResponseCopyWithImpl<_MyStoriesResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MyStoriesResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MyStoriesResponse &&
            const DeepCollectionEquality().equals(other._stories, _stories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_stories));

  @override
  String toString() {
    return 'MyStoriesResponse(stories: $stories)';
  }
}

/// @nodoc
abstract mixin class _$MyStoriesResponseCopyWith<$Res>
    implements $MyStoriesResponseCopyWith<$Res> {
  factory _$MyStoriesResponseCopyWith(
          _MyStoriesResponse value, $Res Function(_MyStoriesResponse) _then) =
      __$MyStoriesResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<MyStoryDetail> stories});
}

/// @nodoc
class __$MyStoriesResponseCopyWithImpl<$Res>
    implements _$MyStoriesResponseCopyWith<$Res> {
  __$MyStoriesResponseCopyWithImpl(this._self, this._then);

  final _MyStoriesResponse _self;
  final $Res Function(_MyStoriesResponse) _then;

  /// Create a copy of MyStoriesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? stories = null,
  }) {
    return _then(_MyStoriesResponse(
      stories: null == stories
          ? _self._stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<MyStoryDetail>,
    ));
  }
}

/// @nodoc
mixin _$MyStoryDetail {
  String get id;
  String get authorId;
  String get mediaUrl;
  String get mediaType;
  String? get caption;
  int get viewCount;
  String get expiresAt;
  String get createdAt;
  List<StoryViewerModel> get views;

  /// Create a copy of MyStoryDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MyStoryDetailCopyWith<MyStoryDetail> get copyWith =>
      _$MyStoryDetailCopyWithImpl<MyStoryDetail>(
          this as MyStoryDetail, _$identity);

  /// Serializes this MyStoryDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyStoryDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other.views, views));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      mediaUrl,
      mediaType,
      caption,
      viewCount,
      expiresAt,
      createdAt,
      const DeepCollectionEquality().hash(views));

  @override
  String toString() {
    return 'MyStoryDetail(id: $id, authorId: $authorId, mediaUrl: $mediaUrl, mediaType: $mediaType, caption: $caption, viewCount: $viewCount, expiresAt: $expiresAt, createdAt: $createdAt, views: $views)';
  }
}

/// @nodoc
abstract mixin class $MyStoryDetailCopyWith<$Res> {
  factory $MyStoryDetailCopyWith(
          MyStoryDetail value, $Res Function(MyStoryDetail) _then) =
      _$MyStoryDetailCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String authorId,
      String mediaUrl,
      String mediaType,
      String? caption,
      int viewCount,
      String expiresAt,
      String createdAt,
      List<StoryViewerModel> views});
}

/// @nodoc
class _$MyStoryDetailCopyWithImpl<$Res>
    implements $MyStoryDetailCopyWith<$Res> {
  _$MyStoryDetailCopyWithImpl(this._self, this._then);

  final MyStoryDetail _self;
  final $Res Function(MyStoryDetail) _then;

  /// Create a copy of MyStoryDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? mediaUrl = null,
    Object? mediaType = null,
    Object? caption = freezed,
    Object? viewCount = null,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? views = null,
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
      mediaUrl: null == mediaUrl
          ? _self.mediaUrl
          : mediaUrl // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      viewCount: null == viewCount
          ? _self.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      views: null == views
          ? _self.views
          : views // ignore: cast_nullable_to_non_nullable
              as List<StoryViewerModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MyStoryDetail].
extension MyStoryDetailPatterns on MyStoryDetail {
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
    TResult Function(_MyStoryDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MyStoryDetail() when $default != null:
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
    TResult Function(_MyStoryDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MyStoryDetail():
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
    TResult? Function(_MyStoryDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MyStoryDetail() when $default != null:
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
            String mediaUrl,
            String mediaType,
            String? caption,
            int viewCount,
            String expiresAt,
            String createdAt,
            List<StoryViewerModel> views)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MyStoryDetail() when $default != null:
        return $default(
            _that.id,
            _that.authorId,
            _that.mediaUrl,
            _that.mediaType,
            _that.caption,
            _that.viewCount,
            _that.expiresAt,
            _that.createdAt,
            _that.views);
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
            String mediaUrl,
            String mediaType,
            String? caption,
            int viewCount,
            String expiresAt,
            String createdAt,
            List<StoryViewerModel> views)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MyStoryDetail():
        return $default(
            _that.id,
            _that.authorId,
            _that.mediaUrl,
            _that.mediaType,
            _that.caption,
            _that.viewCount,
            _that.expiresAt,
            _that.createdAt,
            _that.views);
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
            String mediaUrl,
            String mediaType,
            String? caption,
            int viewCount,
            String expiresAt,
            String createdAt,
            List<StoryViewerModel> views)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MyStoryDetail() when $default != null:
        return $default(
            _that.id,
            _that.authorId,
            _that.mediaUrl,
            _that.mediaType,
            _that.caption,
            _that.viewCount,
            _that.expiresAt,
            _that.createdAt,
            _that.views);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MyStoryDetail implements MyStoryDetail {
  const _MyStoryDetail(
      {required this.id,
      required this.authorId,
      required this.mediaUrl,
      this.mediaType = 'IMAGE',
      this.caption,
      this.viewCount = 0,
      required this.expiresAt,
      required this.createdAt,
      final List<StoryViewerModel> views = const []})
      : _views = views;
  factory _MyStoryDetail.fromJson(Map<String, dynamic> json) =>
      _$MyStoryDetailFromJson(json);

  @override
  final String id;
  @override
  final String authorId;
  @override
  final String mediaUrl;
  @override
  @JsonKey()
  final String mediaType;
  @override
  final String? caption;
  @override
  @JsonKey()
  final int viewCount;
  @override
  final String expiresAt;
  @override
  final String createdAt;
  final List<StoryViewerModel> _views;
  @override
  @JsonKey()
  List<StoryViewerModel> get views {
    if (_views is EqualUnmodifiableListView) return _views;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_views);
  }

  /// Create a copy of MyStoryDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MyStoryDetailCopyWith<_MyStoryDetail> get copyWith =>
      __$MyStoryDetailCopyWithImpl<_MyStoryDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MyStoryDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MyStoryDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._views, _views));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      mediaUrl,
      mediaType,
      caption,
      viewCount,
      expiresAt,
      createdAt,
      const DeepCollectionEquality().hash(_views));

  @override
  String toString() {
    return 'MyStoryDetail(id: $id, authorId: $authorId, mediaUrl: $mediaUrl, mediaType: $mediaType, caption: $caption, viewCount: $viewCount, expiresAt: $expiresAt, createdAt: $createdAt, views: $views)';
  }
}

/// @nodoc
abstract mixin class _$MyStoryDetailCopyWith<$Res>
    implements $MyStoryDetailCopyWith<$Res> {
  factory _$MyStoryDetailCopyWith(
          _MyStoryDetail value, $Res Function(_MyStoryDetail) _then) =
      __$MyStoryDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String authorId,
      String mediaUrl,
      String mediaType,
      String? caption,
      int viewCount,
      String expiresAt,
      String createdAt,
      List<StoryViewerModel> views});
}

/// @nodoc
class __$MyStoryDetailCopyWithImpl<$Res>
    implements _$MyStoryDetailCopyWith<$Res> {
  __$MyStoryDetailCopyWithImpl(this._self, this._then);

  final _MyStoryDetail _self;
  final $Res Function(_MyStoryDetail) _then;

  /// Create a copy of MyStoryDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? mediaUrl = null,
    Object? mediaType = null,
    Object? caption = freezed,
    Object? viewCount = null,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? views = null,
  }) {
    return _then(_MyStoryDetail(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      mediaUrl: null == mediaUrl
          ? _self.mediaUrl
          : mediaUrl // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      viewCount: null == viewCount
          ? _self.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      views: null == views
          ? _self._views
          : views // ignore: cast_nullable_to_non_nullable
              as List<StoryViewerModel>,
    ));
  }
}

// dart format on
