import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/story_bloc.dart';
import '../../domain/models/story_models.dart';
import 'story_circle.dart';

class StoryBar extends StatelessWidget {
  const StoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, StoryState>(
      builder: (context, state) {
        if (state.status == StoryStatus.loading && state.groups.isEmpty) {
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: state.groups.length + 1, // +1 for "Add Story"
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: StoryCircle(
                    username: 'Story',
                    isAddStory: true,
                    hasUnviewed: true,
                    onTap: () => context.push('/story/create'),
                  ),
                );
              }

              final group = state.groups[index - 1];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: StoryCircle(
                  avatarUrl: group.author.avatar,
                  username: group.author.username,
                  hasUnviewed: group.hasUnviewed,
                  onTap: () {
                    context.push('/story/viewer', extra: {
                      'groups': state.groups,
                      'initialGroupIndex': index - 1,
                    });
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
