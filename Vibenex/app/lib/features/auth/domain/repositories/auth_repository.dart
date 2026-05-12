import '../../domain/models/auth_models.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<UserModel> getMe();
  Future<void> forgotPassword(String email);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<UserModel?> tryAutoLogin();
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<void> deleteAccount();
}
