import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
abstract class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
}

@freezed
abstract class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String name,
    required String username,
    required String email,
    required String password,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
}

@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required UserModel user,
    required String accessToken,
    required String refreshToken,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    required String username,
    String? bio,
    String? avatar,
    String? coverPhoto,
    @Default(0) int followersCount,
    @Default(0) int followingCount,
    @Default(0) int postsCount,
    @Default(false) bool isVerified,
    String? createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@freezed
abstract class TokenResponse with _$TokenResponse {
  const factory TokenResponse({
    required String accessToken,
    required String refreshToken,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
}
