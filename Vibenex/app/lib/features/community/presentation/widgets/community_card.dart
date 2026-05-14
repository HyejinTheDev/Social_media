import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../domain/models/community_models.dart';

class CommunityCard extends StatelessWidget {
  final CommunityModel community;

  const CommunityCard({super.key, required this.community});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.surfaceMidnight,
        border: Border.all(color: AppColors.borderTwilight, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
              context.push('/communities/${community.id}');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (community.banner != null)
                  Image.network(
                    community.banner!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 120,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: AppGradients.primary,
                      ),
                      child: const Center(child: Icon(Icons.groups, size: 48, color: Colors.white54)),
                    ),
                  )
                else
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: AppGradients.primary,
                    ),
                    child: const Center(child: Icon(Icons.groups, size: 48, color: Colors.white54)),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (community.icon != null && community.icon!.isNotEmpty)
                            CircleAvatar(
                              backgroundImage: NetworkImage(community.icon!),
                              onBackgroundImageError: (exception, stackTrace) {},
                              radius: 20,
                            )
                          else
                            const CircleAvatar(
                              backgroundColor: AppColors.surfaceContainerHigh,
                              radius: 20,
                              child: Icon(Icons.group, color: AppColors.brandViolet, size: 20),
                            ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  community.name,
                                  style: const TextStyle(
                                    color: AppColors.textSilver,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.people_outline, size: 14, color: AppColors.textFog),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${community.memberCount} members',
                                      style: const TextStyle(color: AppColors.textFog, fontSize: 12),
                                    ),
                                    if (!community.isPublic) ...[
                                      const SizedBox(width: 8),
                                      const Icon(Icons.lock_outline, size: 14, color: AppColors.textFog),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (community.description != null && community.description!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          community.description!,
                          style: const TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
