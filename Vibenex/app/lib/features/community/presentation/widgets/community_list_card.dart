import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../domain/models/community_models.dart';

/// Card cộng đồng nổi bật với banner image, badge TRENDING và nút Join.
class CommunityListCard extends StatelessWidget {
  final CommunityModel community;
  final VoidCallback? onTap;
  final VoidCallback? onJoin;

  const CommunityListCard({
    super.key,
    required this.community,
    this.onTap,
    this.onJoin,
  });

  String _formatMemberCount(int count) {
    if (count >= 1000) {
      final k = count / 1000;
      return '${k.toStringAsFixed(k.truncateToDouble() == k ? 0 : 1)}K members';
    }
    return '$count members';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceMidnight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderTwilight, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner image
            if (community.banner != null)
              Image.network(
                community.banner!,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _bannerPlaceholder(),
              )
            else
              _bannerPlaceholder(),

            // Content area
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row: Icon + Name + TRENDING badge
                  Row(
                    children: [
                      // Community icon
                      if (community.icon != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(community.icon!),
                          radius: 16,
                          backgroundColor: AppColors.surfaceContainerHigh,
                        )
                      else
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.surfaceContainerHigh,
                          child: Icon(Icons.group, color: AppColors.brandViolet, size: 16),
                        ),
                      const SizedBox(width: 10),
                      // Name + member count
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              community.name,
                              style: const TextStyle(
                                color: AppColors.textSilver,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _formatMemberCount(community.memberCount),
                              style: const TextStyle(
                                color: AppColors.textFog,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // TRENDING badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.brandViolet.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'TRENDING',
                          style: TextStyle(
                            color: AppColors.brandViolet,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Description
                  if (community.description != null && community.description!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      community.description!,
                      style: const TextStyle(
                        color: AppColors.textFog,
                        fontSize: 13,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Join button
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 32,
                      child: ElevatedButton(
                        onPressed: onJoin ?? onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brandViolet,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          minimumSize: Size.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        child: const Text('Join'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerPlaceholder() {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppGradients.primary),
      child: const Center(
        child: Icon(Icons.groups_rounded, size: 48, color: Colors.white38),
      ),
    );
  }
}
