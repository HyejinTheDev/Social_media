import 'package:injectable/injectable.dart';
import '../../domain/models/home_models.dart';
import '../../domain/repositories/story_repository.dart';
import '../datasources/story_api_service.dart';

@Injectable(as: StoryRepository)
class StoryRepositoryImpl implements StoryRepository {
  final StoryApiService _apiService;

  StoryRepositoryImpl(this._apiService);

  @override
  Future<List<StoryModel>> getFeed() async {
    final response = await _apiService.getFeed();
    final data = response as List;
    return data.map((e) => StoryModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<StoryModel> createStory({String? imageUrl, String? videoUrl}) async {
    final response = await _apiService.createStory({
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
    });
    return StoryModel.fromJson(response as Map<String, dynamic>);
  }
}
