import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class DioClient {
  late final Dio dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static void Function()? onForceLogout;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: AppConstants.accessTokenKey);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401 &&
            !error.requestOptions.path.contains('/auth/refresh')) {
          try {
            final refreshToken = await _storage.read(key: AppConstants.refreshTokenKey);
            if (refreshToken != null) {
              final cloneDio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
              final res = await cloneDio.post('/auth/refresh', data: {'refreshToken': refreshToken});
              if (res.statusCode == 200) {
                await _storage.write(key: AppConstants.accessTokenKey, value: res.data['accessToken']);
                if (res.data['refreshToken'] != null) {
                  await _storage.write(key: AppConstants.refreshTokenKey, value: res.data['refreshToken']);
                }
                error.requestOptions.headers['Authorization'] = 'Bearer ${res.data['accessToken']}';
                return handler.resolve(await cloneDio.fetch(error.requestOptions));
              }
            }
          } catch (_) {}
          await _storage.delete(key: AppConstants.accessTokenKey);
          await _storage.delete(key: AppConstants.refreshTokenKey);
          onForceLogout?.call();
        }
        handler.next(error);
      },
    ));
  }
}
