import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerSheet extends StatelessWidget {
  final String title;
  final bool showRemove;
  final ValueChanged<ImageSource> onPick;
  final VoidCallback? onRemove;

  const ImagePickerSheet({
    super.key,
    this.title = 'Chọn ảnh',
    this.showRemove = false,
    required this.onPick,
    this.onRemove,
  });

  static Future<void> show(
    BuildContext context, {
    String title = 'Chọn ảnh',
    bool showRemove = false,
    required ValueChanged<ImageSource> onPick,
    VoidCallback? onRemove,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ImagePickerSheet(
        title: title,
        showRemove: showRemove,
        onPick: onPick,
        onRemove: onRemove,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: cs.outlineVariant, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          _Tile(icon: Icons.camera_alt_rounded, label: 'Chụp ảnh', color: cs.primary,
            onTap: () { Navigator.pop(context); onPick(ImageSource.camera); }),
          _Tile(icon: Icons.photo_library_rounded, label: 'Thư viện ảnh', color: cs.secondary,
            onTap: () { Navigator.pop(context); onPick(ImageSource.gallery); }),
          if (showRemove && onRemove != null)
            _Tile(icon: Icons.delete_outline, label: 'Xóa ảnh', color: cs.error,
              onTap: () { Navigator.pop(context); onRemove!(); }),
        ]),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _Tile({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: color),
      ),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
