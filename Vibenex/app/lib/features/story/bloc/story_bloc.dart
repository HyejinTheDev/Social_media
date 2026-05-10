import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../domain/models/story_models.dart';
import '../domain/usecases/story_usecases.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final GetActiveStoriesUseCase _getActiveStories;
  final CreateStoryUseCase _createStory;
  final ViewStoryUseCase _viewStory;
  final DeleteStoryUseCase _deleteStory;

  StoryBloc({
    required GetActiveStoriesUseCase getActiveStories,
    required CreateStoryUseCase createStory,
    required ViewStoryUseCase viewStory,
    required DeleteStoryUseCase deleteStory,
  })  : _getActiveStories = getActiveStories,
        _createStory = createStory,
        _viewStory = viewStory,
        _deleteStory = deleteStory,
        super(const StoryState()) {
    on<StoryLoadRequested>(_onLoadStories);
    on<StoryCreateRequested>(_onCreateStory);
    on<StoryViewRequested>(_onViewStory);
    on<StoryDeleteRequested>(_onDeleteStory);
  }

  Future<void> _onLoadStories(StoryLoadRequested event, Emitter<StoryState> emit) async {
    emit(state.copyWith(status: StoryStatus.loading));
    try {
      final response = await _getActiveStories();
      emit(state.copyWith(
        status: StoryStatus.success,
        groups: response.groups,
      ));
    } catch (e) {
      emit(state.copyWith(status: StoryStatus.failure, errorMessage: ErrorMapper.map(e)));
    }
  }

  Future<void> _onCreateStory(StoryCreateRequested event, Emitter<StoryState> emit) async {
    emit(state.copyWith(createStatus: StoryCreateStatus.loading));
    try {
      await _createStory(media: event.media, caption: event.caption);
      emit(state.copyWith(createStatus: StoryCreateStatus.success));
      // Reload stories
      add(const StoryLoadRequested());
    } catch (e) {
      emit(state.copyWith(
        createStatus: StoryCreateStatus.failure,
        errorMessage: ErrorMapper.map(e),
      ));
    }
  }

  Future<void> _onViewStory(StoryViewRequested event, Emitter<StoryState> emit) async {
    try {
      await _viewStory(event.storyId);
      // Mark story as viewed in local state
      final updatedGroups = state.groups.map((group) {
        final updatedStories = group.stories.map((s) {
          if (s.id == event.storyId) return s.copyWith(isViewed: true);
          return s;
        }).toList();
        final hasUnviewed = updatedStories.any((s) => !s.isViewed);
        return group.copyWith(stories: updatedStories, hasUnviewed: hasUnviewed);
      }).toList();
      emit(state.copyWith(groups: updatedGroups));
    } catch (_) {
      // Silent fail for view tracking
    }
  }

  Future<void> _onDeleteStory(StoryDeleteRequested event, Emitter<StoryState> emit) async {
    try {
      await _deleteStory(event.storyId);
      // Remove story from local state
      final updatedGroups = state.groups.map((group) {
        final updatedStories = group.stories.where((s) => s.id != event.storyId).toList();
        if (updatedStories.isEmpty) return null;
        return group.copyWith(stories: updatedStories);
      }).whereType<StoryGroup>().toList();
      emit(state.copyWith(groups: updatedGroups));
    } catch (e) {
      emit(state.copyWith(errorMessage: ErrorMapper.map(e)));
    }
  }
}
