import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/discussion_models.dart';

/// A card displaying a single discussion thread.
class DiscussionCard extends StatelessWidget {
  final DiscussionModel discussion;

  const DiscussionCard({super.key, required this.discussion});

  String _timeAgo(String? isoDate) {
    if (isoDate == null) return '';
    final dt = DateTime.tryParse(isoDate);
    if (dt == null) return '';
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'vừa xong';
  }

  @override
  Widget build(BuildContext context) {
    final author = discussion.author;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceMidnight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderTwilight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Author Row ───
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.surfaceContainerHigh,
                backgroundImage: author?.avatar != null ? NetworkImage(author!.avatar!) : null,
                child: author?.avatar == null
                    ? Text(
                        (author?.name ?? '?')[0].toUpperCase(),
                        style: const TextStyle(color: AppColors.brandViolet, fontWeight: FontWeight.bold, fontSize: 13),
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      author?.name ?? 'Unknown',
                      style: const TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    Text(
                      _timeAgo(discussion.createdAt),
                      style: const TextStyle(color: AppColors.textFog, fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (discussion.isPinned)
                const Icon(Icons.push_pin, size: 14, color: AppColors.hotPink),
            ],
          ),

          const SizedBox(height: 10),

          // ─── Content ───
          Text(
            discussion.content,
            style: const TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14, height: 1.4),
          ),

          // ─── Images (first one only as preview) ───
          if (discussion.imageUrls.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                discussion.imageUrls.first,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ],

          const SizedBox(height: 10),

          // ─── Footer: Reply count & Reaction count ───
          Row(
            children: [
              const Icon(Icons.chat_bubble_outline, size: 14, color: AppColors.textFog),
              const SizedBox(width: 4),
              Text(
                '${discussion.replyCount}',
                style: const TextStyle(color: AppColors.textFog, fontSize: 12),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.emoji_emotions_outlined, size: 14, color: AppColors.textFog),
              const SizedBox(width: 4),
              Text(
                '${discussion.reactionCount}',
                style: const TextStyle(color: AppColors.textFog, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
