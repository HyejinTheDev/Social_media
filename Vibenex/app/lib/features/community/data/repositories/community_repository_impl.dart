import '../datasources/community_api_service.dart';
import '../../domain/models/community_models.dart';
import '../../domain/repositories/community_repository.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityApiService api;

  CommunityRepositoryImpl({required this.api});

  @override
  Future<PaginatedCommunitiesResponse> getCommunities(int page, int limit, String? search) {
    return api.getCommunities(page, limit, search);
  }

  @override
  Future<CommunityModel> createCommunity(String name, String? description, bool isPublic, bool isVoiceRoom) {
    return api.createCommunity({
      'name': name,
      'description': description,
      'isPublic': isPublic,
      'isVoiceRoom': isVoiceRoom,
    });
  }

  @override
  Future<CommunityModel> getCommunityById(String id) {
    return api.getCommunityById(id);
  }

  @override
  Future<List<ChannelModel>> getChannels(String communityId) {
    return api.getChannels(communityId);
  }

  @override
  Future<void> joinCommunity(String communityId) {
    return api.joinCommunity(communityId);
  }

  @override
  Future<void> leaveCommunity(String communityId) {
    return api.leaveCommunity(communityId);
  }

  @override
  Future<void> deleteCommunity(String id) {
    return api.deleteCommunity(id);
  }
}
