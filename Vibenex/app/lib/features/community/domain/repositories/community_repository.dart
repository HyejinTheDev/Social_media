import '../models/community_models.dart';

abstract class CommunityRepository {
  Future<PaginatedCommunitiesResponse> getCommunities(int page, int limit, String? search);
  Future<CommunityModel> createCommunity(String name, String? description, bool isPublic);
  Future<CommunityModel> getCommunityById(String id);
  Future<List<ChannelModel>> getChannels(String communityId);
}
