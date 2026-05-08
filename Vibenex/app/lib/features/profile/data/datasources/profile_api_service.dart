import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../auth/domain/models/auth_models.dart';

part 'profile_api_service.g.dart';

@RestApi()
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @GET('/users/me')
  Future<UserModel> getMyProfile();

  @PATCH('/users/me')
  Future<UserModel> updateProfile(@Body() Map<String, dynamic> body);
}
