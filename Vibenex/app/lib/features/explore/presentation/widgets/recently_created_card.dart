import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RecentlyCreatedCard extends StatelessWidget {
  final String title;
  final String memberCount;
  final String bannerUrl; // Dùng URL mảng màu hoặc ảnh từ mốc
  final IconData icon;
  final VoidCallback onTap;

  const RecentlyCreatedCard({
    super.key,
    required this.title,
    required this.memberCount,
    required this.bannerUrl,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner
                Image.network(
                  bannerUrl,
                  height: 80,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 80,
                    width: double.infinity,
                    color: AppColors.borderTwilight,
                  ),
                ),
                
                // Nửa dưới (Title & Stats)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 24, 12, 12), // Padding top chừa chỗ cho icon
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.textSilver,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          memberCount,
                          style: TextStyle(
                            color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Badge NEW (góc trên phải)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.badgeNewBg.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.badgeNewBorder.withValues(alpha: 0.5)),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: AppColors.badgeNewText,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            // Icon đè giữa banner và content
            Positioned(
              top: 60, // Lệch nửa icon xuống content
              left: 12,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surfaceMidnight, width: 2),
                ),
                child: Icon(icon, color: AppColors.primary, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
