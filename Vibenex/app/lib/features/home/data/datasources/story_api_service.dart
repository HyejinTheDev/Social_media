import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'story_api_service.g.dart';

@RestApi()
abstract class StoryApiService {
  factory StoryApiService(Dio dio, {String baseUrl}) = _StoryApiService;

  @GET('/stories/feed')
  Future<dynamic> getFeed();

  @POST('/stories')
  Future<dynamic> createStory(@Body() Map<String, dynamic> body);
}
