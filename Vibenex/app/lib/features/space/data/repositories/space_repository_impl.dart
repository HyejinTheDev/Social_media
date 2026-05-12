import '../datasources/space_api_service.dart';
import '../../domain/models/space_models.dart';
import '../../domain/repositories/space_repository.dart';

class SpaceRepositoryImpl implements SpaceRepository {
  final SpaceApiService api;

  SpaceRepositoryImpl({required this.api});

  @override
  Future<PaginatedSpacesResponse> getSpaces(int page, int limit, String? search) {
    return api.getSpaces(page, limit, search);
  }

  @override
  Future<SpaceModel> createSpace(String name, String? description, bool isPrivate) {
    return api.createSpace({
      'name': name,
      'description': description,
      'isPrivate': isPrivate,
    });
  }

  @override
  Future<SpaceModel> getSpaceById(String id) {
    return api.getSpaceById(id);
  }

  @override
  Future<List<ChannelModel>> getChannels(String spaceId) {
    return api.getChannels(spaceId);
  }
}
