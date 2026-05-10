import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/story_models.dart';

part 'story_api_service.g.dart';

@RestApi()
abstract class StoryApiService {
  factory StoryApiService(Dio dio, {String baseUrl}) = _StoryApiService;

  @GET('/stories')
  Future<StoryGroupsResponse> getActiveStories();

  @POST('/stories/{id}/view')
  Future<void> viewStory(@Path('id') String storyId);

  @DELETE('/stories/{id}')
  Future<void> deleteStory(@Path('id') String storyId);

  @GET('/stories/me')
  Future<MyStoriesResponse> getMyStories();
}
