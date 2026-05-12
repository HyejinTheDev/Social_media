// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'space_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpaceModel {
  String get id;
  String get name;
  String? get description;
  String? get avatar;
  String? get coverPhoto;
  bool get isPrivate;
  String get ownerId;
  int get membersCount;
  String? get createdAt;
  String? get updatedAt;

  /// Create a copy of SpaceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SpaceModelCopyWith<SpaceModel> get copyWith =>
      _$SpaceModelCopyWithImpl<SpaceModel>(this as SpaceModel, _$identity);

  /// Serializes this SpaceModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SpaceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.coverPhoto, coverPhoto) ||
                other.coverPhoto == coverPhoto) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.membersCount, membersCount) ||
                other.membersCount == membersCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, avatar,
      coverPhoto, isPrivate, ownerId, membersCount, createdAt, updatedAt);

  @override
  String toString() {
    return 'SpaceModel(id: $id, name: $name, description: $description, avatar: $avatar, coverPhoto: $coverPhoto, isPrivate: $isPrivate, ownerId: $ownerId, membersCount: $membersCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $SpaceModelCopyWith<$Res> {
  factory $SpaceModelCopyWith(
          SpaceModel value, $Res Function(SpaceModel) _then) =
      _$SpaceModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? avatar,
      String? coverPhoto,
      bool isPrivate,
      String ownerId,
      int membersCount,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class _$SpaceModelCopyWithImpl<$Res> implements $SpaceModelCopyWith<$Res> {
  _$SpaceModelCopyWithImpl(this._self, this._then);

  final SpaceModel _self;
  final $Res Function(SpaceModel) _then;

  /// Create a copy of SpaceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? avatar = freezed,
    Object? coverPhoto = freezed,
    Object? isPrivate = null,
    Object? ownerId = null,
    Object? membersCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      coverPhoto: freezed == coverPhoto
          ? _self.coverPhoto
          : coverPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: null == isPrivate
          ? _self.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      membersCount: null == membersCount
          ? _self.membersCount
          : membersCount // ignore: cast_nullable_to_non_nullable
              as int,
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
}

/// Adds pattern-matching-related methods to [SpaceModel].
extension SpaceModelPatterns on SpaceModel {
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
    TResult Function(_SpaceModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SpaceModel() when $default != null:
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
    TResult Function(_SpaceModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SpaceModel():
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
    TResult? Function(_SpaceModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SpaceModel() when $default != null:
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
            String name,
            String? description,
            String? avatar,
            String? coverPhoto,
            bool isPrivate,
            String ownerId,
            int membersCount,
            String? createdAt,
            String? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SpaceModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.avatar,
            _that.coverPhoto,
            _that.isPrivate,
            _that.ownerId,
            _that.membersCount,
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
            String name,
            String? description,
            String? avatar,
            String? coverPhoto,
            bool isPrivate,
            String ownerId,
            int membersCount,
            String? createdAt,
            String? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SpaceModel():
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.avatar,
            _that.coverPhoto,
            _that.isPrivate,
            _that.ownerId,
            _that.membersCount,
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
            String name,
            String? description,
            String? avatar,
            String? coverPhoto,
            bool isPrivate,
            String ownerId,
            int membersCount,
            String? createdAt,
            String? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SpaceModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.avatar,
            _that.coverPhoto,
            _that.isPrivate,
            _that.ownerId,
            _that.membersCount,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SpaceModel implements SpaceModel {
  const _SpaceModel(
      {required this.id,
      required this.name,
      this.description,
      this.avatar,
      this.coverPhoto,
      this.isPrivate = false,
      required this.ownerId,
      this.membersCount = 0,
      this.createdAt,
      this.updatedAt});
  factory _SpaceModel.fromJson(Map<String, dynamic> json) =>
      _$SpaceModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? avatar;
  @override
  final String? coverPhoto;
  @override
  @JsonKey()
  final bool isPrivate;
  @override
  final String ownerId;
  @override
  @JsonKey()
  final int membersCount;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  /// Create a copy of SpaceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SpaceModelCopyWith<_SpaceModel> get copyWith =>
      __$SpaceModelCopyWithImpl<_SpaceModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SpaceModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SpaceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.coverPhoto, coverPhoto) ||
                other.coverPhoto == coverPhoto) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.membersCount, membersCount) ||
                other.membersCount == membersCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, avatar,
      coverPhoto, isPrivate, ownerId, membersCount, createdAt, updatedAt);

  @override
  String toString() {
    return 'SpaceModel(id: $id, name: $name, description: $description, avatar: $avatar, coverPhoto: $coverPhoto, isPrivate: $isPrivate, ownerId: $ownerId, membersCount: $membersCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$SpaceModelCopyWith<$Res>
    implements $SpaceModelCopyWith<$Res> {
  factory _$SpaceModelCopyWith(
          _SpaceModel value, $Res Function(_SpaceModel) _then) =
      __$SpaceModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? avatar,
      String? coverPhoto,
      bool isPrivate,
      String ownerId,
      int membersCount,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class __$SpaceModelCopyWithImpl<$Res> implements _$SpaceModelCopyWith<$Res> {
  __$SpaceModelCopyWithImpl(this._self, this._then);

  final _SpaceModel _self;
  final $Res Function(_SpaceModel) _then;

  /// Create a copy of SpaceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? avatar = freezed,
    Object? coverPhoto = freezed,
    Object? isPrivate = null,
    Object? ownerId = null,
    Object? membersCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_SpaceModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      coverPhoto: freezed == coverPhoto
          ? _self.coverPhoto
          : coverPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: null == isPrivate
          ? _self.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      membersCount: null == membersCount
          ? _self.membersCount
          : membersCount // ignore: cast_nullable_to_non_nullable
              as int,
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
}

/// @nodoc
mixin _$ChannelModel {
  String get id;
  String get spaceId;
  String get name;
  String? get description;
  String get type;
  bool get isPrivate;
  String? get createdAt;
  String? get updatedAt;

  /// Create a copy of ChannelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChannelModelCopyWith<ChannelModel> get copyWith =>
      _$ChannelModelCopyWithImpl<ChannelModel>(
          this as ChannelModel, _$identity);

  /// Serializes this ChannelModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChannelModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.spaceId, spaceId) || other.spaceId == spaceId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, spaceId, name, description,
      type, isPrivate, createdAt, updatedAt);

  @override
  String toString() {
    return 'ChannelModel(id: $id, spaceId: $spaceId, name: $name, description: $description, type: $type, isPrivate: $isPrivate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $ChannelModelCopyWith<$Res> {
  factory $ChannelModelCopyWith(
          ChannelModel value, $Res Function(ChannelModel) _then) =
      _$ChannelModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String spaceId,
      String name,
      String? description,
      String type,
      bool isPrivate,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class _$ChannelModelCopyWithImpl<$Res> implements $ChannelModelCopyWith<$Res> {
  _$ChannelModelCopyWithImpl(this._self, this._then);

  final ChannelModel _self;
  final $Res Function(ChannelModel) _then;

  /// Create a copy of ChannelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? spaceId = null,
    Object? name = null,
    Object? description = freezed,
    Object? type = null,
    Object? isPrivate = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      spaceId: null == spaceId
          ? _self.spaceId
          : spaceId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isPrivate: null == isPrivate
          ? _self.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
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
}

/// Adds pattern-matching-related methods to [ChannelModel].
extension ChannelModelPatterns on ChannelModel {
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
    TResult Function(_ChannelModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelModel() when $default != null:
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
    TResult Function(_ChannelModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelModel():
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
    TResult? Function(_ChannelModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelModel() when $default != null:
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
            String spaceId,
            String name,
            String? description,
            String type,
            bool isPrivate,
            String? createdAt,
            String? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelModel() when $default != null:
        return $default(_that.id, _that.spaceId, _that.name, _that.description,
            _that.type, _that.isPrivate, _that.createdAt, _that.updatedAt);
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
            String spaceId,
            String name,
            String? description,
            String type,
            bool isPrivate,
            String? createdAt,
            String? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelModel():
        return $default(_that.id, _that.spaceId, _that.name, _that.description,
            _that.type, _that.isPrivate, _that.createdAt, _that.updatedAt);
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
            String spaceId,
            String name,
            String? description,
            String type,
            bool isPrivate,
            String? createdAt,
            String? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelModel() when $default != null:
        return $default(_that.id, _that.spaceId, _that.name, _that.description,
            _that.type, _that.isPrivate, _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChannelModel implements ChannelModel {
  const _ChannelModel(
      {required this.id,
      required this.spaceId,
      required this.name,
      this.description,
      this.type = 'TEXT',
      this.isPrivate = false,
      this.createdAt,
      this.updatedAt});
  factory _ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  @override
  final String id;
  @override
  final String spaceId;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final bool isPrivate;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  /// Create a copy of ChannelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChannelModelCopyWith<_ChannelModel> get copyWith =>
      __$ChannelModelCopyWithImpl<_ChannelModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChannelModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChannelModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.spaceId, spaceId) || other.spaceId == spaceId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, spaceId, name, description,
      type, isPrivate, createdAt, updatedAt);

  @override
  String toString() {
    return 'ChannelModel(id: $id, spaceId: $spaceId, name: $name, description: $description, type: $type, isPrivate: $isPrivate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ChannelModelCopyWith<$Res>
    implements $ChannelModelCopyWith<$Res> {
  factory _$ChannelModelCopyWith(
          _ChannelModel value, $Res Function(_ChannelModel) _then) =
      __$ChannelModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String spaceId,
      String name,
      String? description,
      String type,
      bool isPrivate,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class __$ChannelModelCopyWithImpl<$Res>
    implements _$ChannelModelCopyWith<$Res> {
  __$ChannelModelCopyWithImpl(this._self, this._then);

  final _ChannelModel _self;
  final $Res Function(_ChannelModel) _then;

  /// Create a copy of ChannelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? spaceId = null,
    Object? name = null,
    Object? description = freezed,
    Object? type = null,
    Object? isPrivate = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_ChannelModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      spaceId: null == spaceId
          ? _self.spaceId
          : spaceId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isPrivate: null == isPrivate
          ? _self.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
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
}

/// @nodoc
mixin _$PaginatedSpacesResponse {
  List<SpaceModel> get spaces;
  int get total;

  /// Create a copy of PaginatedSpacesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginatedSpacesResponseCopyWith<PaginatedSpacesResponse> get copyWith =>
      _$PaginatedSpacesResponseCopyWithImpl<PaginatedSpacesResponse>(
          this as PaginatedSpacesResponse, _$identity);

  /// Serializes this PaginatedSpacesResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginatedSpacesResponse &&
            const DeepCollectionEquality().equals(other.spaces, spaces) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(spaces), total);

  @override
  String toString() {
    return 'PaginatedSpacesResponse(spaces: $spaces, total: $total)';
  }
}

/// @nodoc
abstract mixin class $PaginatedSpacesResponseCopyWith<$Res> {
  factory $PaginatedSpacesResponseCopyWith(PaginatedSpacesResponse value,
          $Res Function(PaginatedSpacesResponse) _then) =
      _$PaginatedSpacesResponseCopyWithImpl;
  @useResult
  $Res call({List<SpaceModel> spaces, int total});
}

/// @nodoc
class _$PaginatedSpacesResponseCopyWithImpl<$Res>
    implements $PaginatedSpacesResponseCopyWith<$Res> {
  _$PaginatedSpacesResponseCopyWithImpl(this._self, this._then);

  final PaginatedSpacesResponse _self;
  final $Res Function(PaginatedSpacesResponse) _then;

  /// Create a copy of PaginatedSpacesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spaces = null,
    Object? total = null,
  }) {
    return _then(_self.copyWith(
      spaces: null == spaces
          ? _self.spaces
          : spaces // ignore: cast_nullable_to_non_nullable
              as List<SpaceModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PaginatedSpacesResponse].
extension PaginatedSpacesResponsePatterns on PaginatedSpacesResponse {
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
    TResult Function(_PaginatedSpacesResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedSpacesResponse() when $default != null:
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
    TResult Function(_PaginatedSpacesResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedSpacesResponse():
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
    TResult? Function(_PaginatedSpacesResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedSpacesResponse() when $default != null:
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
    TResult Function(List<SpaceModel> spaces, int total)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedSpacesResponse() when $default != null:
        return $default(_that.spaces, _that.total);
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
    TResult Function(List<SpaceModel> spaces, int total) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedSpacesResponse():
        return $default(_that.spaces, _that.total);
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
    TResult? Function(List<SpaceModel> spaces, int total)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedSpacesResponse() when $default != null:
        return $default(_that.spaces, _that.total);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PaginatedSpacesResponse implements PaginatedSpacesResponse {
  const _PaginatedSpacesResponse(
      {required final List<SpaceModel> spaces, required this.total})
      : _spaces = spaces;
  factory _PaginatedSpacesResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedSpacesResponseFromJson(json);

  final List<SpaceModel> _spaces;
  @override
  List<SpaceModel> get spaces {
    if (_spaces is EqualUnmodifiableListView) return _spaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spaces);
  }

  @override
  final int total;

  /// Create a copy of PaginatedSpacesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginatedSpacesResponseCopyWith<_PaginatedSpacesResponse> get copyWith =>
      __$PaginatedSpacesResponseCopyWithImpl<_PaginatedSpacesResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaginatedSpacesResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginatedSpacesResponse &&
            const DeepCollectionEquality().equals(other._spaces, _spaces) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_spaces), total);

  @override
  String toString() {
    return 'PaginatedSpacesResponse(spaces: $spaces, total: $total)';
  }
}

/// @nodoc
abstract mixin class _$PaginatedSpacesResponseCopyWith<$Res>
    implements $PaginatedSpacesResponseCopyWith<$Res> {
  factory _$PaginatedSpacesResponseCopyWith(_PaginatedSpacesResponse value,
          $Res Function(_PaginatedSpacesResponse) _then) =
      __$PaginatedSpacesResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<SpaceModel> spaces, int total});
}

/// @nodoc
class __$PaginatedSpacesResponseCopyWithImpl<$Res>
    implements _$PaginatedSpacesResponseCopyWith<$Res> {
  __$PaginatedSpacesResponseCopyWithImpl(this._self, this._then);

  final _PaginatedSpacesResponse _self;
  final $Res Function(_PaginatedSpacesResponse) _then;

  /// Create a copy of PaginatedSpacesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? spaces = null,
    Object? total = null,
  }) {
    return _then(_PaginatedSpacesResponse(
      spaces: null == spaces
          ? _self._spaces
          : spaces // ignore: cast_nullable_to_non_nullable
              as List<SpaceModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
