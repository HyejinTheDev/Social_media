import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_constants.dart';

class StoryCircle extends StatelessWidget {
  final String? avatarUrl;
  final String username;
  final bool hasUnviewed;
  final bool isAddStory;
  final VoidCallback onTap;

  const StoryCircle({
    super.key,
    this.avatarUrl,
    required this.username,
    this.hasUnviewed = false,
    this.isAddStory = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 76,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar with gradient ring
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: hasUnviewed || isAddStory
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFF006B),
                          Color(0xFFFF6B35),
                          Color(0xFFFFD700),
                          Color(0xFF7B2FF7),
                        ],
                      )
                    : LinearGradient(
                        colors: [
                          Colors.grey.withValues(alpha: 0.3),
                          Colors.grey.withValues(alpha: 0.3),
                        ],
                      ),
              ),
              padding: const EdgeInsets.all(2.5),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.surface,
                ),
                padding: const EdgeInsets.all(2),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                          ? CachedNetworkImageProvider(
                              avatarUrl!.startsWith('http')
                                  ? avatarUrl!
                                  : '${AppConstants.baseUrl}$avatarUrl',
                            )
                          : null,
                      child: avatarUrl == null || avatarUrl!.isEmpty
                          ? Icon(Icons.person, size: 28, color: colorScheme.onSurfaceVariant)
                          : null,
                    ),
                    if (isAddStory)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: colorScheme.surface, width: 2),
                          ),
                          child: const Icon(Icons.add, size: 14, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isAddStory ? 'Story' : username,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
