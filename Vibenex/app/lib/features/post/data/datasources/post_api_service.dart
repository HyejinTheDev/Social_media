import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/post_models.dart';

part 'post_api_service.g.dart';

@RestApi()
abstract class PostApiService {
  factory PostApiService(Dio dio) = _PostApiService;

  @GET('/posts')
  Future<PaginatedPostsResponse> getFeed(@Query('page') int page, @Query('limit') int limit);

  @GET('/posts/user/{userId}')
  Future<PaginatedPostsResponse> getUserPosts(@Path('userId') String userId, @Query('page') int page, @Query('limit') int limit);

  @GET('/posts/{id}')
  Future<PostModel> getPostById(@Path('id') String id);

  @DELETE('/posts/{id}')
  Future<void> deletePost(@Path('id') String id);

  @POST('/posts/{id}/like')
  Future<dynamic> toggleLike(@Path('id') String id);

  @GET('/posts/{id}/like-status')
  Future<dynamic> getLikeStatus(@Path('id') String id);

  @GET('/posts/{postId}/comments')
  Future<PaginatedCommentsResponse> getComments(@Path('postId') String postId, @Query('page') int page, @Query('limit') int limit);

  @POST('/posts/{postId}/comments')
  Future<CommentModel> addComment(@Path('postId') String postId, @Body() Map<String, dynamic> body);

  @DELETE('/comments/{id}')
  Future<void> deleteComment(@Path('id') String id);
}
