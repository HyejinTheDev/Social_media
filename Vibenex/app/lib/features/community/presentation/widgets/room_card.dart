import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';

class RoomCard extends StatelessWidget {
  final String roomName;
  final int participantCount;
  final List<String> speakerAvatars;
  final List<String> speakerNames;
  final bool isVoiceRoom;
  final VoidCallback? onTap;
  final Widget? trailing;

  const RoomCard({
    super.key,
    required this.roomName,
    required this.participantCount,
    required this.speakerAvatars,
    this.speakerNames = const [],
    this.isVoiceRoom = true,
    this.onTap,
    this.trailing,
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
                  if (participantCount > 0)
                    Row(
                      children: [
                        // Member avatars stack (use names for initials)
                        if (speakerNames.isNotEmpty)
                          SizedBox(
                            width: speakerNames.length * 20.0 + 10,
                            height: 28,
                            child: Stack(
                              children: List.generate(
                                speakerNames.length,
                                (index) => Positioned(
                                  left: index * 20.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.surfaceMidnight, width: 2),
                                    ),
                                    child: AvatarWidget(
                                      imageUrl: index < speakerAvatars.length ? speakerAvatars[index] : null,
                                      name: speakerNames[index],
                                      radius: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (speakerNames.isNotEmpty) const SizedBox(width: 8),
                        // Participant count
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.person, size: 14, color: AppColors.textFog),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '$participantCount tham gia',
                                  style: const TextStyle(
                                    color: AppColors.textFog,
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            // Join Button / Trailing
            if (trailing != null)
              trailing!
            else
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
