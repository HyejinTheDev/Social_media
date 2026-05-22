import '../../domain/repositories/explore_repository.dart';
import '../../../auth/domain/models/auth_models.dart';
import '../../../community/domain/models/community_models.dart';
import '../../../profile/data/datasources/profile_api_service.dart';
import '../../../community/data/datasources/community_api_service.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ProfileApiService _profileApi;
  final CommunityApiService _communityApi;

  ExploreRepositoryImpl({
    required ProfileApiService profileApi,
    required CommunityApiService communityApi,
  })  : _profileApi = profileApi,
        _communityApi = communityApi;

  @override
  Future<ExploreSearchResult> search(String query, {int page = 1}) async {
    final results = await Future.wait([
      _profileApi.searchUsers(query, page),
      _communityApi.getCommunities(page, 10, query),
    ]);

    final userRes = results[0] as Map<String, dynamic>;
    final communityRes = results[1] as PaginatedCommunitiesResponse;

    final users = (userRes['users'] as List)
        .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final communities = communityRes.communities;

    return ExploreSearchResult(
      users: users,
      communities: communities,
      totalUsers: (userRes['total'] as int?) ?? 0,
    );
  }
}
