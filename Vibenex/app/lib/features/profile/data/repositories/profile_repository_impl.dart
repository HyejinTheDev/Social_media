import 'dart:io';
import 'package:dio/dio.dart';
import '../../../auth/domain/models/auth_models.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_api_service.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _api;
  final Dio _dio;

  ProfileRepositoryImpl({required ProfileApiService api, required Dio dio})
      : _api = api,
        _dio = dio;

  @override
  Future<UserModel> getMyProfile() => _api.getMyProfile();

  @override
  Future<Map<String, dynamic>> getUserById(String id) async {
    final res = await _dio.get('/users/$id');
    return res.data as Map<String, dynamic>;
  }

  @override
  Future<UserModel> updateProfile({String? name, String? username, String? bio}) {
    final data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (username != null) data['username'] = username;
    if (bio != null) data['bio'] = bio;
    return _api.updateProfile(data);
  }

  @override
  Future<UserModel> uploadAvatar(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: file.path.split(Platform.pathSeparator).last),
    });
    final res = await _dio.post('/users/me/avatar', data: formData);
    return UserModel.fromJson(res.data);
  }

  @override
  Future<UserModel> uploadCover(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: file.path.split(Platform.pathSeparator).last),
    });
    final res = await _dio.post('/users/me/cover', data: formData);
    return UserModel.fromJson(res.data);
  }

  @override
  Future<Map<String, dynamic>> searchUsers(String query, {int page = 1}) async {
    final res = await _dio.get('/users/search', queryParameters: {'q': query, 'page': page});
    return res.data as Map<String, dynamic>;
  }
}
