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
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data['message'] != null) {
          final msg = data['message'];
          return msg is List ? msg.first.toString() : msg.toString();
        }
        return switch (e.response?.statusCode) {
          400 => 'Dữ liệu không hợp lệ.',
          401 => 'Phiên đăng nhập hết hạn.',
          403 => 'Bạn không có quyền thực hiện thao tác này.',
          404 => 'Không tìm thấy dữ liệu.',
          409 => 'Dữ liệu đã tồn tại.',
          500 => 'Lỗi máy chủ.',
          _ => 'Lỗi (${e.response?.statusCode}).',
        };
      default:
        return 'Đã có lỗi xảy ra.';
    }
  }
}
