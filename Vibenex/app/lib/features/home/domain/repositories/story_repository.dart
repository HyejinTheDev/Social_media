import '../../domain/models/home_models.dart';

abstract class StoryRepository {
  Future<List<StoryModel>> getFeed();
  Future<StoryModel> createStory({String? imageUrl, String? videoUrl});
}
