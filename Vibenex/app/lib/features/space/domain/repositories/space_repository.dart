import '../models/space_models.dart';

abstract class SpaceRepository {
  Future<PaginatedSpacesResponse> getSpaces(int page, int limit, String? search);
  Future<SpaceModel> createSpace(String name, String? description, bool isPrivate);
  Future<SpaceModel> getSpaceById(String id);
  Future<List<ChannelModel>> getChannels(String spaceId);
}
