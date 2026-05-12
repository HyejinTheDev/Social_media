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
  Future<CommunityModel> createCommunity(String name, String? description, bool isPublic) {
    return api.createCommunity({
      'name': name,
      'description': description,
      'isPublic': isPublic,
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
}
