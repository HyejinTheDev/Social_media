import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/space_models.dart';

part 'space_api_service.g.dart';

@RestApi()
abstract class SpaceApiService {
  factory SpaceApiService(Dio dio) = _SpaceApiService;

  @GET('/spaces')
  Future<PaginatedSpacesResponse> getSpaces(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('search') String? search,
  );

  @POST('/spaces')
  Future<SpaceModel> createSpace(@Body() Map<String, dynamic> body);

  @GET('/spaces/{id}')
  Future<SpaceModel> getSpaceById(@Path('id') String id);

  @GET('/spaces/{spaceId}/channels')
  Future<List<ChannelModel>> getChannels(@Path('spaceId') String spaceId);
}
