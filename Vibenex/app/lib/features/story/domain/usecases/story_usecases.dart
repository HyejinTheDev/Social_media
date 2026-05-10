import 'dart:io';
import '../models/story_models.dart';
import '../models/story_repository.dart';

class GetActiveStoriesUseCase {
  final StoryRepository _repo;
  GetActiveStoriesUseCase(this._repo);

  Future<StoryGroupsResponse> call() => _repo.getActiveStories();
}

class CreateStoryUseCase {
  final StoryRepository _repo;
  CreateStoryUseCase(this._repo);

  Future<StoryModel> call({required File media, String? caption}) =>
      _repo.createStory(media: media, caption: caption);
}

class ViewStoryUseCase {
  final StoryRepository _repo;
  ViewStoryUseCase(this._repo);

  Future<void> call(String storyId) => _repo.viewStory(storyId);
}

class DeleteStoryUseCase {
  final StoryRepository _repo;
  DeleteStoryUseCase(this._repo);

  Future<void> call(String storyId) => _repo.deleteStory(storyId);
}

class GetMyStoriesUseCase {
  final StoryRepository _repo;
  GetMyStoriesUseCase(this._repo);

  Future<MyStoriesResponse> call() => _repo.getMyStories();
}
