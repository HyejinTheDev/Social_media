import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/discussion_models.dart';

part 'discussion_api_service.g.dart';

@RestApi()
abstract class DiscussionApiService {
  factory DiscussionApiService(Dio dio) = _DiscussionApiService;

  // ─── Discussions ───
  @GET('/channels/{channelId}/discussions')
  Future<PaginatedDiscussionsResponse> getDiscussions(
    @Path('channelId') String channelId,
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @POST('/channels/{channelId}/discussions')
  Future<DiscussionModel> createDiscussion(
    @Path('channelId') String channelId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/discussions/{id}')
  Future<DiscussionModel> getDiscussionById(@Path('id') String id);

  // ─── Replies ───
  @GET('/discussions/{discussionId}/replies')
  Future<List<ReplyModel>> getReplies(
    @Path('discussionId') String discussionId,
  );

  @POST('/discussions/{discussionId}/replies')
  Future<ReplyModel> createReply(
    @Path('discussionId') String discussionId,
    @Body() Map<String, dynamic> body,
  );
}
