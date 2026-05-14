import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:io';

part 'post_api_service.g.dart';

@RestApi()
abstract class PostApiService {
  factory PostApiService(Dio dio, {String baseUrl}) = _PostApiService;

  @GET('/posts/feed')
  Future<dynamic> getFeed(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @GET('/posts/user/{userId}')
  Future<dynamic> getUserPosts(
    @Path('userId') String userId,
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @POST('/posts')
  Future<dynamic> createPost(
    @Body() Map<String, dynamic> body,
  );

  @POST('/posts/upload')
  @MultiPart()
  Future<dynamic> uploadMedia(
    @Part(name: 'file') File file,
  );

  @POST('/posts/{id}/like')
  Future<dynamic> toggleLike(
    @Path('id') String id,
  );

  @GET('/posts/{id}/comments')
  Future<dynamic> getComments(
    @Path('id') String id,
  );

  @POST('/posts/{id}/comments')
  Future<dynamic> createComment(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );
}
