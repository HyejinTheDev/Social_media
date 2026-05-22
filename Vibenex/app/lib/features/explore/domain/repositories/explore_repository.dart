import '../../../auth/domain/models/auth_models.dart';
import '../../../community/domain/models/community_models.dart';

abstract class ExploreRepository {
  Future<ExploreSearchResult> search(String query, {int page = 1});
}

class ExploreSearchResult {
  final List<UserModel> users;
  final List<CommunityModel> communities;
  final int totalUsers;

  ExploreSearchResult({
    required this.users,
    required this.communities,
    required this.totalUsers,
  });

  int get total => totalUsers + communities.length;
}
