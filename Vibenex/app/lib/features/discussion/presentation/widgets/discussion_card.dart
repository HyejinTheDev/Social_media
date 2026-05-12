import 'package:flutter/material.dart';
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
    final cs = Theme.of(context).colorScheme;
    final author = discussion.author;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Author Row ───
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: cs.primary.withValues(alpha: 0.3),
                backgroundImage: author?.avatar != null ? NetworkImage(author!.avatar!) : null,
                child: author?.avatar == null
                    ? Text(
                        (author?.name ?? '?')[0].toUpperCase(),
                        style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold, fontSize: 13),
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
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    Text(
                      _timeAgo(discussion.createdAt),
                      style: TextStyle(color: cs.onSurfaceVariant, fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (discussion.isPinned)
                Icon(Icons.push_pin, size: 14, color: cs.secondary),
            ],
          ),

          const SizedBox(height: 10),

          // ─── Content ───
          Text(
            discussion.content,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 14, height: 1.4),
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
              Icon(Icons.chat_bubble_outline, size: 14, color: cs.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                '${discussion.replyCount}',
                style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
              ),
              const SizedBox(width: 16),
              Icon(Icons.emoji_emotions_outlined, size: 14, color: cs.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                '${discussion.reactionCount}',
                style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
