import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/community_models.dart';

part 'community_api_service.g.dart';

@RestApi()
abstract class CommunityApiService {
  factory CommunityApiService(Dio dio) = _CommunityApiService;

  @GET('/communities')
  Future<PaginatedCommunitiesResponse> getCommunities(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('search') String? search,
  );

  @POST('/communities')
  Future<CommunityModel> createCommunity(@Body() Map<String, dynamic> body);

  @GET('/communities/{id}')
  Future<CommunityModel> getCommunityById(@Path('id') String id);

  @GET('/communities/{communityId}/channels')
  Future<List<ChannelModel>> getChannels(@Path('communityId') String communityId);

  @POST('/communities/{communityId}/join')
  Future<void> joinCommunity(@Path('communityId') String communityId);

  @POST('/communities/{communityId}/leave')
  Future<void> leaveCommunity(@Path('communityId') String communityId);

  @DELETE('/communities/{id}')
  Future<void> deleteCommunity(@Path('id') String id);

  @PATCH('/communities/{id}')
  Future<CommunityModel> updateCommunity(@Path('id') String id, @Body() Map<String, dynamic> body);
}
