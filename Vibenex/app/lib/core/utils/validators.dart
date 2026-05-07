class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Vui lòng nhập email';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) return 'Email không hợp lệ';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Vui lòng nhập mật khẩu';
    if (value.length < 8) return 'Mật khẩu phải có ít nhất 8 ký tự';
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) return 'Vui lòng xác nhận mật khẩu';
    if (value != password) return 'Mật khẩu không khớp';
    return null;
  }

  static String? required(String? value, [String field = 'Trường này']) {
    if (value == null || value.trim().isEmpty) return '$field không được để trống';
    return null;
  }

  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) return 'Vui lòng nhập tên người dùng';
    final regex = RegExp(r'^[a-z0-9_]{3,20}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Chỉ chữ thường, số và _ (3-20 ký tự)';
    }
    return null;
  }

  static String? bio(String? value) {
    if (value != null && value.length > 150) return 'Tiểu sử tối đa 150 ký tự';
    return null;
  }
}
