part of 'story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();
  @override
  List<Object?> get props => [];
}

class StoryLoadRequested extends StoryEvent {
  const StoryLoadRequested();
}

class StoryCreateRequested extends StoryEvent {
  final File media;
  final String? caption;
  const StoryCreateRequested({required this.media, this.caption});
  @override
  List<Object?> get props => [media, caption];
}

class StoryViewRequested extends StoryEvent {
  final String storyId;
  const StoryViewRequested(this.storyId);
  @override
  List<Object?> get props => [storyId];
}

class StoryDeleteRequested extends StoryEvent {
  final String storyId;
  const StoryDeleteRequested(this.storyId);
  @override
  List<Object?> get props => [storyId];
}
