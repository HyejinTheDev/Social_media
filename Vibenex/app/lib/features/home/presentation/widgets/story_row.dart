import 'package:flutter/material.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../domain/models/home_models.dart';

class StoryRow extends StatelessWidget {
  final List<StoryModel> stories;

  const StoryRow({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _StoryItem(story: story),
          );
        },
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final StoryModel story;

  const _StoryItem({required this.story});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: !story.isViewed && !story.isOwn
                    ? AppGradients.primary
                    : null,
                color: story.isViewed || story.isOwn
                    ? Colors.transparent
                    : null,
                border: story.isViewed || story.isOwn
                    ? Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 2,
                      )
                    : null,
              ),
              child: AvatarWidget(
                imageUrl: story.userAvatar,
                radius: 32,
              ),
            ),
            if (story.isOwn)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 74,
          child: Text(
            story.userName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: story.isOwn ? FontWeight.w600 : FontWeight.normal,
                ),
          ),
        ),
      ],
    );
  }
}
