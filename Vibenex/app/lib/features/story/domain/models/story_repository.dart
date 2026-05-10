import 'dart:io';
import 'story_models.dart';

abstract class StoryRepository {
  Future<StoryGroupsResponse> getActiveStories();
  Future<StoryModel> createStory({required File media, String? caption});
  Future<void> viewStory(String storyId);
  Future<void> deleteStory(String storyId);
  Future<MyStoriesResponse> getMyStories();
}
