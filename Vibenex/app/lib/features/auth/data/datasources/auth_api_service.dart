import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/auth_models.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('/auth/register')
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  @POST('/auth/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @POST('/auth/refresh')
  Future<TokenResponse> refreshToken(@Body() Map<String, dynamic> body);

  @GET('/auth/me')
  Future<UserModel> getMe();

  @POST('/auth/forgot-password')
  Future<void> forgotPassword(@Body() Map<String, dynamic> body);
}
