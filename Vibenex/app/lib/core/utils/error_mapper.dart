import 'package:dio/dio.dart';

class ErrorMapper {
  ErrorMapper._();
  static String map(Object error) {
    if (error is DioException) return _mapDio(error);
    return 'Đã có lỗi xảy ra. Vui lòng thử lại.';
  }
  static String _mapDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Kết nối quá chậm. Vui lòng thử lại.';
      case DioExceptionType.connectionError:
        return 'Không thể kết nối đến máy chủ.';
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        // Known status codes → Vietnamese messages
        if (code == 401) return 'Phiên đăng nhập hết hạn.';
        if (code == 403) return 'Bạn không có quyền thực hiện thao tác này.';
        if (code == 404) return 'Không tìm thấy dữ liệu.';
        if (code == 500) return 'Lỗi máy chủ.';
        // Custom messages from backend (validation errors, etc.)
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data['message'] != null) {
          final msg = data['message'];
          return msg is List ? msg.first.toString() : msg.toString();
        }
        return switch (code) {
          400 => 'Dữ liệu không hợp lệ.',
          409 => 'Dữ liệu đã tồn tại.',
          _ => 'Lỗi ($code).',
        };
      default:
        return 'Đã có lỗi xảy ra.';
    }
  }
}
