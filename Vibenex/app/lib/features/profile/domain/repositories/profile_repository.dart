import 'dart:io';
import '../../../auth/domain/models/auth_models.dart';

abstract class ProfileRepository {
  Future<UserModel> getMyProfile();
  Future<Map<String, dynamic>> getUserById(String id);
  Future<UserModel> updateProfile({String? name, String? username, String? bio});
  Future<UserModel> uploadAvatar(File file);
  Future<UserModel> uploadCover(File file);
  Future<Map<String, dynamic>> searchUsers(String query, {int page = 1});
}
