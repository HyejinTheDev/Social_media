import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class DioClient {
  late final Dio dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static void Function()? onForceLogout;

  // Refresh token lock to prevent race conditions
  bool _isRefreshing = false;
  Completer<String?>? _refreshCompleter;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
        headers: {'Accept': 'application/json'},
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
            !error.requestOptions.path.contains('/auth/refresh') &&
            !error.requestOptions.path.contains('/auth/login')) {
          final newToken = await _tryRefreshToken();
          if (newToken != null) {
            // Retry original request with new token
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            try {
              final cloneDio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl, contentType: 'application/json'));
              cloneDio.options.headers['Authorization'] = 'Bearer $newToken';
              final response = await cloneDio.fetch(error.requestOptions);
              return handler.resolve(response);
            } catch (retryError) {
              return handler.next(error);
            }
          } else {
            // Refresh failed → force logout
            await _storage.delete(key: AppConstants.accessTokenKey);
            await _storage.delete(key: AppConstants.refreshTokenKey);
            onForceLogout?.call();
          }
        }
        handler.next(error);
      },
    ));
  }

  /// Refresh token with lock to prevent multiple simultaneous refreshes
  Future<String?> _tryRefreshToken() async {
    // If already refreshing, wait for the result
    if (_isRefreshing) {
      return _refreshCompleter?.future;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<String?>();

    try {
      final refreshToken = await _storage.read(key: AppConstants.refreshTokenKey);
      if (refreshToken == null) {
        _refreshCompleter!.complete(null);
        return null;
      }

      final cloneDio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl, contentType: 'application/json'));
      final res = await cloneDio.post('/auth/refresh', data: {'refreshToken': refreshToken});

      if (res.statusCode == 200 || res.statusCode == 201) {
        final newAccess = res.data['accessToken'] as String;
        await _storage.write(key: AppConstants.accessTokenKey, value: newAccess);
        if (res.data['refreshToken'] != null) {
          await _storage.write(key: AppConstants.refreshTokenKey, value: res.data['refreshToken']);
        }
        _refreshCompleter!.complete(newAccess);
        return newAccess;
      }
      _refreshCompleter!.complete(null);
      return null;
    } catch (_) {
      _refreshCompleter!.complete(null);
      return null;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }
}
