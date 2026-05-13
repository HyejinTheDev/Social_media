import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Thư viện Gradients dựa trên Stitch Design System cho Vibenex
class AppGradients {
  AppGradients._();

  /// Gradient dùng cho các action chính (Button, banner)
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.brandViolet,
      AppColors.electricIndigo,
    ],
  );

  /// Gradient dùng cho stories, badges, avatar rings
  static const LinearGradient story = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      AppColors.brandViolet,
      AppColors.hotPink,
      AppColors.statusAmber,
    ],
  );

  // ==================== Category Gradients (Your Spaces) ====================

  /// Design category — tím đậm → tím nhạt
  static const LinearGradient categoryDesign = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7C3AED), Color(0xFFA78BFA)],
  );

  /// Dev / Flutter category — xanh dương đậm → xanh nhạt
  static const LinearGradient categoryDev = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2563EB), Color(0xFF60A5FA)],
  );

  /// Gaming category — đỏ → cam
  static const LinearGradient categoryGaming = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFDC2626), Color(0xFFF97316)],
  );

  /// Photo category — xanh lá đậm → xanh lá nhạt
  static const LinearGradient categoryPhoto = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF059669), Color(0xFF34D399)],
  );

  /// Music category — vàng đậm → vàng nhạt
  static const LinearGradient categoryMusic = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD97706), Color(0xFFFBBF24)],
  );
}
