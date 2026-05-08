// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginRequest {
  String get email;
  String get password;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginRequestCopyWith<LoginRequest> get copyWith =>
      _$LoginRequestCopyWithImpl<LoginRequest>(
          this as LoginRequest, _$identity);

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginRequest &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @override
  String toString() {
    return 'LoginRequest(email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class $LoginRequestCopyWith<$Res> {
  factory $LoginRequestCopyWith(
          LoginRequest value, $Res Function(LoginRequest) _then) =
      _$LoginRequestCopyWithImpl;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginRequestCopyWithImpl<$Res> implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._self, this._then);

  final LoginRequest _self;
  final $Res Function(LoginRequest) _then;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_self.copyWith(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [LoginRequest].
extension LoginRequestPatterns on LoginRequest {
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
    TResult Function(_LoginRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginRequest() when $default != null:
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
    TResult Function(_LoginRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginRequest():
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
    TResult? Function(_LoginRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginRequest() when $default != null:
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
    TResult Function(String email, String password)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginRequest() when $default != null:
        return $default(_that.email, _that.password);
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
    TResult Function(String email, String password) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginRequest():
        return $default(_that.email, _that.password);
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
    TResult? Function(String email, String password)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginRequest() when $default != null:
        return $default(_that.email, _that.password);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LoginRequest implements LoginRequest {
  const _LoginRequest({required this.email, required this.password});
  factory _LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  @override
  final String email;
  @override
  final String password;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginRequestCopyWith<_LoginRequest> get copyWith =>
      __$LoginRequestCopyWithImpl<_LoginRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LoginRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginRequest &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @override
  String toString() {
    return 'LoginRequest(email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class _$LoginRequestCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$LoginRequestCopyWith(
          _LoginRequest value, $Res Function(_LoginRequest) _then) =
      __$LoginRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$LoginRequestCopyWithImpl<$Res>
    implements _$LoginRequestCopyWith<$Res> {
  __$LoginRequestCopyWithImpl(this._self, this._then);

  final _LoginRequest _self;
  final $Res Function(_LoginRequest) _then;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_LoginRequest(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RegisterRequest {
  String get name;
  String get username;
  String get email;
  String get password;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegisterRequestCopyWith<RegisterRequest> get copyWith =>
      _$RegisterRequestCopyWithImpl<RegisterRequest>(
          this as RegisterRequest, _$identity);

  /// Serializes this RegisterRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegisterRequest &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, username, email, password);

  @override
  String toString() {
    return 'RegisterRequest(name: $name, username: $username, email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class $RegisterRequestCopyWith<$Res> {
  factory $RegisterRequestCopyWith(
          RegisterRequest value, $Res Function(RegisterRequest) _then) =
      _$RegisterRequestCopyWithImpl;
  @useResult
  $Res call({String name, String username, String email, String password});
}

/// @nodoc
class _$RegisterRequestCopyWithImpl<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  _$RegisterRequestCopyWithImpl(this._self, this._then);

  final RegisterRequest _self;
  final $Res Function(RegisterRequest) _then;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? username = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RegisterRequest].
extension RegisterRequestPatterns on RegisterRequest {
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
    TResult Function(_RegisterRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegisterRequest() when $default != null:
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
    TResult Function(_RegisterRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterRequest():
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
    TResult? Function(_RegisterRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterRequest() when $default != null:
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
            String name, String username, String email, String password)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegisterRequest() when $default != null:
        return $default(
            _that.name, _that.username, _that.email, _that.password);
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
            String name, String username, String email, String password)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterRequest():
        return $default(
            _that.name, _that.username, _that.email, _that.password);
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
            String name, String username, String email, String password)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterRequest() when $default != null:
        return $default(
            _that.name, _that.username, _that.email, _that.password);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegisterRequest implements RegisterRequest {
  const _RegisterRequest(
      {required this.name,
      required this.username,
      required this.email,
      required this.password});
  factory _RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  @override
  final String name;
  @override
  final String username;
  @override
  final String email;
  @override
  final String password;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegisterRequestCopyWith<_RegisterRequest> get copyWith =>
      __$RegisterRequestCopyWithImpl<_RegisterRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RegisterRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegisterRequest &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, username, email, password);

  @override
  String toString() {
    return 'RegisterRequest(name: $name, username: $username, email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class _$RegisterRequestCopyWith<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  factory _$RegisterRequestCopyWith(
          _RegisterRequest value, $Res Function(_RegisterRequest) _then) =
      __$RegisterRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String username, String email, String password});
}

/// @nodoc
class __$RegisterRequestCopyWithImpl<$Res>
    implements _$RegisterRequestCopyWith<$Res> {
  __$RegisterRequestCopyWithImpl(this._self, this._then);

  final _RegisterRequest _self;
  final $Res Function(_RegisterRequest) _then;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? username = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_RegisterRequest(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$AuthResponse {
  UserModel get user;
  String get accessToken;
  String get refreshToken;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthResponseCopyWith<AuthResponse> get copyWith =>
      _$AuthResponseCopyWithImpl<AuthResponse>(
          this as AuthResponse, _$identity);

  /// Serializes this AuthResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthResponse &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, accessToken, refreshToken);

  @override
  String toString() {
    return 'AuthResponse(user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $AuthResponseCopyWith<$Res> {
  factory $AuthResponseCopyWith(
          AuthResponse value, $Res Function(AuthResponse) _then) =
      _$AuthResponseCopyWithImpl;
  @useResult
  $Res call({UserModel user, String accessToken, String refreshToken});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$AuthResponseCopyWithImpl<$Res> implements $AuthResponseCopyWith<$Res> {
  _$AuthResponseCopyWithImpl(this._self, this._then);

  final AuthResponse _self;
  final $Res Function(AuthResponse) _then;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_self.copyWith(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// Adds pattern-matching-related methods to [AuthResponse].
extension AuthResponsePatterns on AuthResponse {
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
    TResult Function(_AuthResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthResponse() when $default != null:
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
    TResult Function(_AuthResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthResponse():
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
    TResult? Function(_AuthResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthResponse() when $default != null:
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
    TResult Function(UserModel user, String accessToken, String refreshToken)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthResponse() when $default != null:
        return $default(_that.user, _that.accessToken, _that.refreshToken);
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
    TResult Function(UserModel user, String accessToken, String refreshToken)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthResponse():
        return $default(_that.user, _that.accessToken, _that.refreshToken);
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
    TResult? Function(UserModel user, String accessToken, String refreshToken)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthResponse() when $default != null:
        return $default(_that.user, _that.accessToken, _that.refreshToken);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AuthResponse implements AuthResponse {
  const _AuthResponse(
      {required this.user,
      required this.accessToken,
      required this.refreshToken});
  factory _AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  @override
  final UserModel user;
  @override
  final String accessToken;
  @override
  final String refreshToken;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthResponseCopyWith<_AuthResponse> get copyWith =>
      __$AuthResponseCopyWithImpl<_AuthResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuthResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthResponse &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, accessToken, refreshToken);

  @override
  String toString() {
    return 'AuthResponse(user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$AuthResponseCopyWith<$Res>
    implements $AuthResponseCopyWith<$Res> {
  factory _$AuthResponseCopyWith(
          _AuthResponse value, $Res Function(_AuthResponse) _then) =
      __$AuthResponseCopyWithImpl;
  @override
  @useResult
  $Res call({UserModel user, String accessToken, String refreshToken});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$AuthResponseCopyWithImpl<$Res>
    implements _$AuthResponseCopyWith<$Res> {
  __$AuthResponseCopyWithImpl(this._self, this._then);

  final _AuthResponse _self;
  final $Res Function(_AuthResponse) _then;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_AuthResponse(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// @nodoc
mixin _$UserModel {
  String get id;
  String get email;
  String get name;
  String get username;
  String? get bio;
  String? get avatar;
  String? get coverPhoto;
  int get followersCount;
  int get followingCount;
  int get postsCount;
  bool get isVerified;
  String? get createdAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<UserModel> get copyWith =>
      _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.coverPhoto, coverPhoto) ||
                other.coverPhoto == coverPhoto) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.postsCount, postsCount) ||
                other.postsCount == postsCount) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      name,
      username,
      bio,
      avatar,
      coverPhoto,
      followersCount,
      followingCount,
      postsCount,
      isVerified,
      createdAt);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, username: $username, bio: $bio, avatar: $avatar, coverPhoto: $coverPhoto, followersCount: $followersCount, followingCount: $followingCount, postsCount: $postsCount, isVerified: $isVerified, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) =
      _$UserModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      String username,
      String? bio,
      String? avatar,
      String? coverPhoto,
      int followersCount,
      int followingCount,
      int postsCount,
      bool isVerified,
      String? createdAt});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? username = null,
    Object? bio = freezed,
    Object? avatar = freezed,
    Object? coverPhoto = freezed,
    Object? followersCount = null,
    Object? followingCount = null,
    Object? postsCount = null,
    Object? isVerified = null,
    Object? createdAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      coverPhoto: freezed == coverPhoto
          ? _self.coverPhoto
          : coverPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      followersCount: null == followersCount
          ? _self.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _self.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      postsCount: null == postsCount
          ? _self.postsCount
          : postsCount // ignore: cast_nullable_to_non_nullable
              as int,
      isVerified: null == isVerified
          ? _self.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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
    TResult Function(_UserModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
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
    TResult Function(_UserModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel():
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
    TResult? Function(_UserModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
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
            String email,
            String name,
            String username,
            String? bio,
            String? avatar,
            String? coverPhoto,
            int followersCount,
            int followingCount,
            int postsCount,
            bool isVerified,
            String? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
        return $default(
            _that.id,
            _that.email,
            _that.name,
            _that.username,
            _that.bio,
            _that.avatar,
            _that.coverPhoto,
            _that.followersCount,
            _that.followingCount,
            _that.postsCount,
            _that.isVerified,
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
            String email,
            String name,
            String username,
            String? bio,
            String? avatar,
            String? coverPhoto,
            int followersCount,
            int followingCount,
            int postsCount,
            bool isVerified,
            String? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel():
        return $default(
            _that.id,
            _that.email,
            _that.name,
            _that.username,
            _that.bio,
            _that.avatar,
            _that.coverPhoto,
            _that.followersCount,
            _that.followingCount,
            _that.postsCount,
            _that.isVerified,
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
            String email,
            String name,
            String username,
            String? bio,
            String? avatar,
            String? coverPhoto,
            int followersCount,
            int followingCount,
            int postsCount,
            bool isVerified,
            String? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
        return $default(
            _that.id,
            _that.email,
            _that.name,
            _that.username,
            _that.bio,
            _that.avatar,
            _that.coverPhoto,
            _that.followersCount,
            _that.followingCount,
            _that.postsCount,
            _that.isVerified,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserModel implements UserModel {
  const _UserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.username,
      this.bio,
      this.avatar,
      this.coverPhoto,
      this.followersCount = 0,
      this.followingCount = 0,
      this.postsCount = 0,
      this.isVerified = false,
      this.createdAt});
  factory _UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String username;
  @override
  final String? bio;
  @override
  final String? avatar;
  @override
  final String? coverPhoto;
  @override
  @JsonKey()
  final int followersCount;
  @override
  @JsonKey()
  final int followingCount;
  @override
  @JsonKey()
  final int postsCount;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  final String? createdAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserModelCopyWith<_UserModel> get copyWith =>
      __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.coverPhoto, coverPhoto) ||
                other.coverPhoto == coverPhoto) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.postsCount, postsCount) ||
                other.postsCount == postsCount) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      name,
      username,
      bio,
      avatar,
      coverPhoto,
      followersCount,
      followingCount,
      postsCount,
      isVerified,
      createdAt);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, username: $username, bio: $bio, avatar: $avatar, coverPhoto: $coverPhoto, followersCount: $followersCount, followingCount: $followingCount, postsCount: $postsCount, isVerified: $isVerified, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(
          _UserModel value, $Res Function(_UserModel) _then) =
      __$UserModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      String username,
      String? bio,
      String? avatar,
      String? coverPhoto,
      int followersCount,
      int followingCount,
      int postsCount,
      bool isVerified,
      String? createdAt});
}

/// @nodoc
class __$UserModelCopyWithImpl<$Res> implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? username = null,
    Object? bio = freezed,
    Object? avatar = freezed,
    Object? coverPhoto = freezed,
    Object? followersCount = null,
    Object? followingCount = null,
    Object? postsCount = null,
    Object? isVerified = null,
    Object? createdAt = freezed,
  }) {
    return _then(_UserModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      coverPhoto: freezed == coverPhoto
          ? _self.coverPhoto
          : coverPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      followersCount: null == followersCount
          ? _self.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _self.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      postsCount: null == postsCount
          ? _self.postsCount
          : postsCount // ignore: cast_nullable_to_non_nullable
              as int,
      isVerified: null == isVerified
          ? _self.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$TokenResponse {
  String get accessToken;
  String get refreshToken;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenResponseCopyWith<TokenResponse> get copyWith =>
      _$TokenResponseCopyWithImpl<TokenResponse>(
          this as TokenResponse, _$identity);

  /// Serializes this TokenResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenResponse &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @override
  String toString() {
    return 'TokenResponse(accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $TokenResponseCopyWith<$Res> {
  factory $TokenResponseCopyWith(
          TokenResponse value, $Res Function(TokenResponse) _then) =
      _$TokenResponseCopyWithImpl;
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class _$TokenResponseCopyWithImpl<$Res>
    implements $TokenResponseCopyWith<$Res> {
  _$TokenResponseCopyWithImpl(this._self, this._then);

  final TokenResponse _self;
  final $Res Function(TokenResponse) _then;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_self.copyWith(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TokenResponse].
extension TokenResponsePatterns on TokenResponse {
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
    TResult Function(_TokenResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TokenResponse() when $default != null:
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
    TResult Function(_TokenResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenResponse():
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
    TResult? Function(_TokenResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenResponse() when $default != null:
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
    TResult Function(String accessToken, String refreshToken)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TokenResponse() when $default != null:
        return $default(_that.accessToken, _that.refreshToken);
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
    TResult Function(String accessToken, String refreshToken) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenResponse():
        return $default(_that.accessToken, _that.refreshToken);
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
    TResult? Function(String accessToken, String refreshToken)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenResponse() when $default != null:
        return $default(_that.accessToken, _that.refreshToken);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TokenResponse implements TokenResponse {
  const _TokenResponse({required this.accessToken, required this.refreshToken});
  factory _TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenResponseCopyWith<_TokenResponse> get copyWith =>
      __$TokenResponseCopyWithImpl<_TokenResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TokenResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenResponse &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @override
  String toString() {
    return 'TokenResponse(accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$TokenResponseCopyWith<$Res>
    implements $TokenResponseCopyWith<$Res> {
  factory _$TokenResponseCopyWith(
          _TokenResponse value, $Res Function(_TokenResponse) _then) =
      __$TokenResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class __$TokenResponseCopyWithImpl<$Res>
    implements _$TokenResponseCopyWith<$Res> {
  __$TokenResponseCopyWithImpl(this._self, this._then);

  final _TokenResponse _self;
  final $Res Function(_TokenResponse) _then;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_TokenResponse(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
