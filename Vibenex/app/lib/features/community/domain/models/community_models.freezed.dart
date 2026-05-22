// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityModel {
  String get id;
  String get name;
  String? get description;
  String? get icon;
  String? get banner;
  bool get isPublic;
  bool get isVoiceRoom;
  int get memberCount;
  List<String> get participantAvatars;
  List<String> get participantNames;
  String? get createdAt;
  String? get updatedAt;

  /// Create a copy of CommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommunityModelCopyWith<CommunityModel> get copyWith =>
      _$CommunityModelCopyWithImpl<CommunityModel>(
          this as CommunityModel, _$identity);

  /// Serializes this CommunityModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommunityModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.isVoiceRoom, isVoiceRoom) ||
                other.isVoiceRoom == isVoiceRoom) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            const DeepCollectionEquality()
                .equals(other.participantAvatars, participantAvatars) &&
            const DeepCollectionEquality()
                .equals(other.participantNames, participantNames) &&
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
      name,
      description,
      icon,
      banner,
      isPublic,
      isVoiceRoom,
      memberCount,
      const DeepCollectionEquality().hash(participantAvatars),
      const DeepCollectionEquality().hash(participantNames),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'CommunityModel(id: $id, name: $name, description: $description, icon: $icon, banner: $banner, isPublic: $isPublic, isVoiceRoom: $isVoiceRoom, memberCount: $memberCount, participantAvatars: $participantAvatars, participantNames: $participantNames, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $CommunityModelCopyWith<$Res> {
  factory $CommunityModelCopyWith(
          CommunityModel value, $Res Function(CommunityModel) _then) =
      _$CommunityModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? icon,
      String? banner,
      bool isPublic,
      bool isVoiceRoom,
      int memberCount,
      List<String> participantAvatars,
      List<String> participantNames,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class _$CommunityModelCopyWithImpl<$Res>
    implements $CommunityModelCopyWith<$Res> {
  _$CommunityModelCopyWithImpl(this._self, this._then);

  final CommunityModel _self;
  final $Res Function(CommunityModel) _then;

  /// Create a copy of CommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? banner = freezed,
    Object? isPublic = null,
    Object? isVoiceRoom = null,
    Object? memberCount = null,
    Object? participantAvatars = null,
    Object? participantNames = null,
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
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      banner: freezed == banner
          ? _self.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      isPublic: null == isPublic
          ? _self.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      isVoiceRoom: null == isVoiceRoom
          ? _self.isVoiceRoom
          : isVoiceRoom // ignore: cast_nullable_to_non_nullable
              as bool,
      memberCount: null == memberCount
          ? _self.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      participantAvatars: null == participantAvatars
          ? _self.participantAvatars
          : participantAvatars // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participantNames: null == participantNames
          ? _self.participantNames
          : participantNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
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

/// Adds pattern-matching-related methods to [CommunityModel].
extension CommunityModelPatterns on CommunityModel {
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
    TResult Function(_CommunityModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CommunityModel() when $default != null:
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
    TResult Function(_CommunityModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommunityModel():
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
    TResult? Function(_CommunityModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommunityModel() when $default != null:
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
            String? icon,
            String? banner,
            bool isPublic,
            bool isVoiceRoom,
            int memberCount,
            List<String> participantAvatars,
            List<String> participantNames,
            String? createdAt,
            String? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CommunityModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.icon,
            _that.banner,
            _that.isPublic,
            _that.isVoiceRoom,
            _that.memberCount,
            _that.participantAvatars,
            _that.participantNames,
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
            String? icon,
            String? banner,
            bool isPublic,
            bool isVoiceRoom,
            int memberCount,
            List<String> participantAvatars,
            List<String> participantNames,
            String? createdAt,
            String? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommunityModel():
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.icon,
            _that.banner,
            _that.isPublic,
            _that.isVoiceRoom,
            _that.memberCount,
            _that.participantAvatars,
            _that.participantNames,
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
            String? icon,
            String? banner,
            bool isPublic,
            bool isVoiceRoom,
            int memberCount,
            List<String> participantAvatars,
            List<String> participantNames,
            String? createdAt,
            String? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommunityModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.icon,
            _that.banner,
            _that.isPublic,
            _that.isVoiceRoom,
            _that.memberCount,
            _that.participantAvatars,
            _that.participantNames,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CommunityModel implements CommunityModel {
  const _CommunityModel(
      {required this.id,
      required this.name,
      this.description,
      this.icon,
      this.banner,
      this.isPublic = true,
      this.isVoiceRoom = false,
      this.memberCount = 0,
      final List<String> participantAvatars = const [],
      final List<String> participantNames = const [],
      this.createdAt,
      this.updatedAt})
      : _participantAvatars = participantAvatars,
        _participantNames = participantNames;
  factory _CommunityModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? icon;
  @override
  final String? banner;
  @override
  @JsonKey()
  final bool isPublic;
  @override
  @JsonKey()
  final bool isVoiceRoom;
  @override
  @JsonKey()
  final int memberCount;
  final List<String> _participantAvatars;
  @override
  @JsonKey()
  List<String> get participantAvatars {
    if (_participantAvatars is EqualUnmodifiableListView)
      return _participantAvatars;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantAvatars);
  }

  final List<String> _participantNames;
  @override
  @JsonKey()
  List<String> get participantNames {
    if (_participantNames is EqualUnmodifiableListView)
      return _participantNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantNames);
  }

  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  /// Create a copy of CommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommunityModelCopyWith<_CommunityModel> get copyWith =>
      __$CommunityModelCopyWithImpl<_CommunityModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CommunityModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommunityModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.isVoiceRoom, isVoiceRoom) ||
                other.isVoiceRoom == isVoiceRoom) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            const DeepCollectionEquality()
                .equals(other._participantAvatars, _participantAvatars) &&
            const DeepCollectionEquality()
                .equals(other._participantNames, _participantNames) &&
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
      name,
      description,
      icon,
      banner,
      isPublic,
      isVoiceRoom,
      memberCount,
      const DeepCollectionEquality().hash(_participantAvatars),
      const DeepCollectionEquality().hash(_participantNames),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'CommunityModel(id: $id, name: $name, description: $description, icon: $icon, banner: $banner, isPublic: $isPublic, isVoiceRoom: $isVoiceRoom, memberCount: $memberCount, participantAvatars: $participantAvatars, participantNames: $participantNames, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$CommunityModelCopyWith<$Res>
    implements $CommunityModelCopyWith<$Res> {
  factory _$CommunityModelCopyWith(
          _CommunityModel value, $Res Function(_CommunityModel) _then) =
      __$CommunityModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? icon,
      String? banner,
      bool isPublic,
      bool isVoiceRoom,
      int memberCount,
      List<String> participantAvatars,
      List<String> participantNames,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class __$CommunityModelCopyWithImpl<$Res>
    implements _$CommunityModelCopyWith<$Res> {
  __$CommunityModelCopyWithImpl(this._self, this._then);

  final _CommunityModel _self;
  final $Res Function(_CommunityModel) _then;

  /// Create a copy of CommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? banner = freezed,
    Object? isPublic = null,
    Object? isVoiceRoom = null,
    Object? memberCount = null,
    Object? participantAvatars = null,
    Object? participantNames = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_CommunityModel(
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
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      banner: freezed == banner
          ? _self.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      isPublic: null == isPublic
          ? _self.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      isVoiceRoom: null == isVoiceRoom
          ? _self.isVoiceRoom
          : isVoiceRoom // ignore: cast_nullable_to_non_nullable
              as bool,
      memberCount: null == memberCount
          ? _self.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      participantAvatars: null == participantAvatars
          ? _self._participantAvatars
          : participantAvatars // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participantNames: null == participantNames
          ? _self._participantNames
          : participantNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
  String get communityId;
  String get name;
  String? get description;
  String get type;
  int get position;
  String? get createdAt;

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
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, communityId, name,
      description, type, position, createdAt);

  @override
  String toString() {
    return 'ChannelModel(id: $id, communityId: $communityId, name: $name, description: $description, type: $type, position: $position, createdAt: $createdAt)';
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
      String communityId,
      String name,
      String? description,
      String type,
      int position,
      String? createdAt});
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
    Object? communityId = null,
    Object? name = null,
    Object? description = freezed,
    Object? type = null,
    Object? position = null,
    Object? createdAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      communityId: null == communityId
          ? _self.communityId
          : communityId // ignore: cast_nullable_to_non_nullable
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
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
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
    TResult Function(String id, String communityId, String name,
            String? description, String type, int position, String? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelModel() when $default != null:
        return $default(_that.id, _that.communityId, _that.name,
            _that.description, _that.type, _that.position, _that.createdAt);
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
    TResult Function(String id, String communityId, String name,
            String? description, String type, int position, String? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelModel():
        return $default(_that.id, _that.communityId, _that.name,
            _that.description, _that.type, _that.position, _that.createdAt);
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
    TResult? Function(String id, String communityId, String name,
            String? description, String type, int position, String? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelModel() when $default != null:
        return $default(_that.id, _that.communityId, _that.name,
            _that.description, _that.type, _that.position, _that.createdAt);
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
      required this.communityId,
      required this.name,
      this.description,
      this.type = 'TEXT',
      this.position = 0,
      this.createdAt});
  factory _ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  @override
  final String id;
  @override
  final String communityId;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final int position;
  @override
  final String? createdAt;

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
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, communityId, name,
      description, type, position, createdAt);

  @override
  String toString() {
    return 'ChannelModel(id: $id, communityId: $communityId, name: $name, description: $description, type: $type, position: $position, createdAt: $createdAt)';
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
      String communityId,
      String name,
      String? description,
      String type,
      int position,
      String? createdAt});
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
    Object? communityId = null,
    Object? name = null,
    Object? description = freezed,
    Object? type = null,
    Object? position = null,
    Object? createdAt = freezed,
  }) {
    return _then(_ChannelModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      communityId: null == communityId
          ? _self.communityId
          : communityId // ignore: cast_nullable_to_non_nullable
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
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$PaginatedCommunitiesResponse {
  List<CommunityModel> get communities;
  int get total;

  /// Create a copy of PaginatedCommunitiesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginatedCommunitiesResponseCopyWith<PaginatedCommunitiesResponse>
      get copyWith => _$PaginatedCommunitiesResponseCopyWithImpl<
              PaginatedCommunitiesResponse>(
          this as PaginatedCommunitiesResponse, _$identity);

  /// Serializes this PaginatedCommunitiesResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginatedCommunitiesResponse &&
            const DeepCollectionEquality()
                .equals(other.communities, communities) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(communities), total);

  @override
  String toString() {
    return 'PaginatedCommunitiesResponse(communities: $communities, total: $total)';
  }
}

/// @nodoc
abstract mixin class $PaginatedCommunitiesResponseCopyWith<$Res> {
  factory $PaginatedCommunitiesResponseCopyWith(
          PaginatedCommunitiesResponse value,
          $Res Function(PaginatedCommunitiesResponse) _then) =
      _$PaginatedCommunitiesResponseCopyWithImpl;
  @useResult
  $Res call({List<CommunityModel> communities, int total});
}

/// @nodoc
class _$PaginatedCommunitiesResponseCopyWithImpl<$Res>
    implements $PaginatedCommunitiesResponseCopyWith<$Res> {
  _$PaginatedCommunitiesResponseCopyWithImpl(this._self, this._then);

  final PaginatedCommunitiesResponse _self;
  final $Res Function(PaginatedCommunitiesResponse) _then;

  /// Create a copy of PaginatedCommunitiesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communities = null,
    Object? total = null,
  }) {
    return _then(_self.copyWith(
      communities: null == communities
          ? _self.communities
          : communities // ignore: cast_nullable_to_non_nullable
              as List<CommunityModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PaginatedCommunitiesResponse].
extension PaginatedCommunitiesResponsePatterns on PaginatedCommunitiesResponse {
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
    TResult Function(_PaginatedCommunitiesResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommunitiesResponse() when $default != null:
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
    TResult Function(_PaginatedCommunitiesResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommunitiesResponse():
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
    TResult? Function(_PaginatedCommunitiesResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommunitiesResponse() when $default != null:
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
    TResult Function(List<CommunityModel> communities, int total)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommunitiesResponse() when $default != null:
        return $default(_that.communities, _that.total);
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
    TResult Function(List<CommunityModel> communities, int total) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommunitiesResponse():
        return $default(_that.communities, _that.total);
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
    TResult? Function(List<CommunityModel> communities, int total)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedCommunitiesResponse() when $default != null:
        return $default(_that.communities, _that.total);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PaginatedCommunitiesResponse implements PaginatedCommunitiesResponse {
  const _PaginatedCommunitiesResponse(
      {required final List<CommunityModel> communities, required this.total})
      : _communities = communities;
  factory _PaginatedCommunitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedCommunitiesResponseFromJson(json);

  final List<CommunityModel> _communities;
  @override
  List<CommunityModel> get communities {
    if (_communities is EqualUnmodifiableListView) return _communities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_communities);
  }

  @override
  final int total;

  /// Create a copy of PaginatedCommunitiesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginatedCommunitiesResponseCopyWith<_PaginatedCommunitiesResponse>
      get copyWith => __$PaginatedCommunitiesResponseCopyWithImpl<
          _PaginatedCommunitiesResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaginatedCommunitiesResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginatedCommunitiesResponse &&
            const DeepCollectionEquality()
                .equals(other._communities, _communities) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_communities), total);

  @override
  String toString() {
    return 'PaginatedCommunitiesResponse(communities: $communities, total: $total)';
  }
}

/// @nodoc
abstract mixin class _$PaginatedCommunitiesResponseCopyWith<$Res>
    implements $PaginatedCommunitiesResponseCopyWith<$Res> {
  factory _$PaginatedCommunitiesResponseCopyWith(
          _PaginatedCommunitiesResponse value,
          $Res Function(_PaginatedCommunitiesResponse) _then) =
      __$PaginatedCommunitiesResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<CommunityModel> communities, int total});
}

/// @nodoc
class __$PaginatedCommunitiesResponseCopyWithImpl<$Res>
    implements _$PaginatedCommunitiesResponseCopyWith<$Res> {
  __$PaginatedCommunitiesResponseCopyWithImpl(this._self, this._then);

  final _PaginatedCommunitiesResponse _self;
  final $Res Function(_PaginatedCommunitiesResponse) _then;

  /// Create a copy of PaginatedCommunitiesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? communities = null,
    Object? total = null,
  }) {
    return _then(_PaginatedCommunitiesResponse(
      communities: null == communities
          ? _self._communities
          : communities // ignore: cast_nullable_to_non_nullable
              as List<CommunityModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
