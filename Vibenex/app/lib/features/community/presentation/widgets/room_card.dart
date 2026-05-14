import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';

class RoomCard extends StatelessWidget {
  final String roomName;
  final int participantCount;
  final List<String> speakerAvatars;
  final bool isVoiceRoom;
  final VoidCallback? onTap;

  const RoomCard({
    super.key,
    required this.roomName,
    required this.participantCount,
    required this.speakerAvatars,
    this.isVoiceRoom = true,
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
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderTwilight, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isVoiceRoom ? AppColors.statusEmerald.withValues(alpha: 0.1) : AppColors.brandViolet.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isVoiceRoom ? Icons.volume_up : Icons.chat_bubble_outline,
                color: isVoiceRoom ? AppColors.statusEmerald : AppColors.brandViolet,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomName,
                    style: const TextStyle(
                      color: AppColors.textSilver,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      // Speaker avatars stack
                      SizedBox(
                        width: speakerAvatars.length * 20.0 + 10,
                        height: 28,
                        child: Stack(
                          children: List.generate(
                            speakerAvatars.length,
                            (index) => Positioned(
                              left: index * 20.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.surfaceMidnight, width: 2),
                                ),
                                child: AvatarWidget(
                                  imageUrl: speakerAvatars[index],
                                  radius: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Participant count
                      Row(
                        children: [
                          const Icon(Icons.person, size: 14, color: AppColors.textFog),
                          const SizedBox(width: 4),
                          Text(
                            '$participantCount người đang tham gia',
                            style: const TextStyle(
                              color: AppColors.textFog,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Join Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.brandViolet.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Tham gia',
                style: TextStyle(
                  color: AppColors.brandViolet,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
