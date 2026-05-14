import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';

class CreatePostBar extends StatelessWidget {
  final String currentUserAvatar;

  const CreatePostBar({super.key, required this.currentUserAvatar});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: AppColors.surfaceMidnight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          AvatarWidget(
            imageUrl: currentUserAvatar,
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.push('/create-post');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderTwilight),
                ),
                child: Text(
                  'Bạn đang nghĩ gì?',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.image, color: Colors.greenAccent),
            onPressed: () {
              context.push('/create-post');
            },
            tooltip: 'Thêm ảnh',
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.redAccent),
            onPressed: () {
              context.push('/create-post');
            },
            tooltip: 'Thêm video',
          ),
        ],
      ),
    );
  }
}
