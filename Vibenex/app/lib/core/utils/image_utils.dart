import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

/// Utility for picking and compressing images
class ImageUtils {
  ImageUtils._();

  static final _picker = ImagePicker();

  /// Pick image from gallery or camera
  static Future<File?> pickImage({
    required ImageSource source,
    int maxWidth = 1080,
    int maxHeight = 1080,
    int quality = 80,
  }) async {
    try {
      final picked = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: quality,
      );
      if (picked == null) return null;
      return File(picked.path);
    } catch (e) {
      debugPrint('ImageUtils.pickImage error: $e');
      return null;
    }
  }

  /// Pick avatar (square, smaller size)
  static Future<File?> pickAvatar({required ImageSource source}) {
    return pickImage(source: source, maxWidth: 512, maxHeight: 512, quality: 85);
  }

  /// Pick cover photo (wider, larger)
  static Future<File?> pickCover({required ImageSource source}) {
    return pickImage(source: source, maxWidth: 1920, maxHeight: 1080, quality: 80);
  }
}
