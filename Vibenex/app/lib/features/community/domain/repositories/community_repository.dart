import '../models/community_models.dart';

abstract class CommunityRepository {
  Future<PaginatedCommunitiesResponse> getCommunities(int page, int limit, String? search);
  Future<CommunityModel> createCommunity(String name, String? description, bool isPublic, bool isVoiceRoom);
  Future<CommunityModel> getCommunityById(String id);
  Future<List<ChannelModel>> getChannels(String communityId);
  Future<void> joinCommunity(String communityId);
  Future<void> leaveCommunity(String communityId);
  Future<void> deleteCommunity(String id);
}
