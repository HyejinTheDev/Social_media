import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/models/auth_models.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _api;
  final FlutterSecureStorage _storage;

  AuthRepositoryImpl({
    required AuthApiService api,
    FlutterSecureStorage? storage,
  })  : _api = api,
        _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    final response = await _api.login(request.toJson());
    await _saveTokens(response.accessToken, response.refreshToken);
    return response;
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    final response = await _api.register(request.toJson());
    await _saveTokens(response.accessToken, response.refreshToken);
    return response;
  }

  @override
  Future<UserModel> getMe() async {
    return await _api.getMe();
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _api.forgotPassword({'email': email});
  }

  @override
  Future<void> logout() async {
    await _storage.delete(key: AppConstants.accessTokenKey);
    await _storage.delete(key: AppConstants.refreshTokenKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: AppConstants.accessTokenKey);
    return token != null;
  }

  @override
  Future<UserModel?> tryAutoLogin() async {
    final token = await _storage.read(key: AppConstants.accessTokenKey);
    if (token == null) return null;
    try {
      return await _api.getMe();
    } catch (_) {
      return null;
    }
  }

  Future<void> _saveTokens(String access, String refresh) async {
    await _storage.write(key: AppConstants.accessTokenKey, value: access);
    await _storage.write(key: AppConstants.refreshTokenKey, value: refresh);
  }
}
