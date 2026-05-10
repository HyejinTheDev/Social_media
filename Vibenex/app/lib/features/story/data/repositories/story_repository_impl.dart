import 'dart:io';
import 'package:dio/dio.dart';
import '../../domain/models/story_models.dart';
import '../../domain/models/story_repository.dart';
import '../datasources/story_api_service.dart';

class StoryRepositoryImpl implements StoryRepository {
  final StoryApiService _api;
  final Dio _dio;

  StoryRepositoryImpl({required StoryApiService api, required Dio dio})
      : _api = api,
        _dio = dio;

  @override
  Future<StoryGroupsResponse> getActiveStories() => _api.getActiveStories();

  @override
  Future<StoryModel> createStory({required File media, String? caption}) async {
    final formData = FormData.fromMap({
      'media': await MultipartFile.fromFile(
        media.path,
        filename: media.path.split(RegExp(r'[/\\]')).last,
      ),
      if (caption != null && caption.isNotEmpty) 'caption': caption,
    });

    final response = await _dio.post('/stories', data: formData);
    return StoryModel.fromJson(response.data);
  }

  @override
  Future<void> viewStory(String storyId) => _api.viewStory(storyId);

  @override
  Future<void> deleteStory(String storyId) => _api.deleteStory(storyId);

  @override
  Future<MyStoriesResponse> getMyStories() => _api.getMyStories();
}
