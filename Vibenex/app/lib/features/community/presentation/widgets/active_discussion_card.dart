import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Card thảo luận sôi nổi cho phần "Active Discussions" trên trang Home.
class ActiveDiscussionCard extends StatelessWidget {
  final String authorName;
  final String? authorAvatar;
  final String? badge;
  final Color badgeColor;
  final String content;
  final int replyCount;
  final int likeCount;
  final String timeAgo;
  final VoidCallback? onTap;

  const ActiveDiscussionCard({
    super.key,
    required this.authorName,
    this.authorAvatar,
    this.badge,
    this.badgeColor = AppColors.brandViolet,
    required this.content,
    this.replyCount = 0,
    this.likeCount = 0,
    this.timeAgo = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceMidnight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderTwilight, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author header
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.surfaceContainerHigh,
                  backgroundImage: authorAvatar != null ? NetworkImage(authorAvatar!) : null,
                  child: authorAvatar == null
                      ? Text(
                          authorName.isNotEmpty ? authorName[0].toUpperCase() : '?',
                          style: const TextStyle(
                            color: AppColors.brandViolet,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 10),
                // Author name
                Flexible(
                  child: Text(
                    authorName,
                    style: const TextStyle(
                      color: AppColors.textSilver,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Badge
                if (badge != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge!,
                      style: TextStyle(
                        color: badgeColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 10),

            // Content
            Text(
              content,
              style: const TextStyle(
                color: AppColors.textSilver,
                fontSize: 14,
                height: 1.45,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Footer stats
            Row(
              children: [
                _buildActionIcon(Icons.chat_bubble_outline, replyCount.toString(), AppColors.textFog),
                const SizedBox(width: 16),
                _buildActionIcon(Icons.favorite, likeCount.toString(), Colors.redAccent),
                const Spacer(),
                Text(
                  timeAgo,
                  style: const TextStyle(color: AppColors.textFog, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String count, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          count,
          style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
