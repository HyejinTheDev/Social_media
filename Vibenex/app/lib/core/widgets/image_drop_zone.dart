import 'dart:io';
import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';

/// A drop zone that accepts image files via drag-and-drop.
/// Also tappable for manual pick. Works on Mobile/Web/Desktop.
class ImageDropZone extends StatefulWidget {
  final Widget child;
  final ValueChanged<File> onFileDropped;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const ImageDropZone({
    super.key,
    required this.child,
    required this.onFileDropped,
    this.onTap,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  State<ImageDropZone> createState() => _ImageDropZoneState();
}

class _ImageDropZoneState extends State<ImageDropZone> {
  bool _isDragging = false;

  static const _allowedExtensions = ['.jpg', '.jpeg', '.png', '.webp', '.gif'];

  bool _isImage(String path) {
    final ext = path.toLowerCase();
    return _allowedExtensions.any((e) => ext.endsWith(e));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return DropTarget(
      onDragEntered: (_) => setState(() => _isDragging = true),
      onDragExited: (_) => setState(() => _isDragging = false),
      onDragDone: (details) {
        setState(() => _isDragging = false);
        if (details.files.isNotEmpty) {
          final file = details.files.first;
          if (_isImage(file.path)) {
            widget.onFileDropped(File(file.path));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Chỉ hỗ trợ ảnh (JPG, PNG, WebP)'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: cs.error,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ));
          }
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            border: _isDragging
                ? Border.all(color: cs.primary, width: 3, strokeAlign: BorderSide.strokeAlignOutside)
                : null,
          ),
          child: Stack(children: [
            widget.child,
            // Drag overlay
            if (_isDragging)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.3),
                    borderRadius: widget.borderRadius,
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: cs.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
                      ),
                      child: const Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.file_download, color: Colors.white, size: 22),
                        SizedBox(width: 8),
                        Text('Thả ảnh vào đây', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                      ]),
                    ),
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
