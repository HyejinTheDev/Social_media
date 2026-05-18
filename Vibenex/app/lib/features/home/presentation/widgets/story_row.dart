import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../domain/models/home_models.dart';
import '../pages/story_viewer_page.dart';

class StoryRow extends StatelessWidget {
  final List<StoryModel> stories;
  final String currentUserAvatar;

  const StoryRow({
    super.key,
    required this.stories,
    required this.currentUserAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _CreateStoryItem(avatar: currentUserAvatar),
            );
          }
          final story = stories[index - 1];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _StoryItem(
              story: story,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StoryViewerPage(
                      stories: stories,
                      initialIndex: index - 1,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final StoryModel story;
  final VoidCallback? onTap;

  const _StoryItem({required this.story, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: !story.isViewed ? AppGradients.primary : null,
                  color: story.isViewed ? Colors.transparent : null,
                  border: story.isViewed
                      ? Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 2,
                        )
                      : null,
                ),
                child: AvatarWidget(
                  imageUrl: story.author.avatar,
                  radius: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 74,
            child: Text(
              story.author.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateStoryItem extends StatelessWidget {
  final String avatar;

  const _CreateStoryItem({required this.avatar});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/create-story'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 2,
                  ),
                ),
                child: AvatarWidget(
                  imageUrl: avatar,
                  radius: 32,
                ),
              ),
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
              'Bạn',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
