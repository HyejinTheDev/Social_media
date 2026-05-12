import '../datasources/discussion_api_service.dart';
import '../../domain/models/discussion_models.dart';
import '../../domain/repositories/discussion_repository.dart';

class DiscussionRepositoryImpl implements DiscussionRepository {
  final DiscussionApiService api;

  DiscussionRepositoryImpl({required this.api});

  @override
  Future<PaginatedDiscussionsResponse> getDiscussions(String channelId, int page, int limit) {
    return api.getDiscussions(channelId, page, limit);
  }

  @override
  Future<DiscussionModel> createDiscussion(String channelId, String content, List<String> imageUrls, String? linkUrl) {
    return api.createDiscussion(channelId, {
      'content': content,
      'imageUrls': imageUrls,
      if (linkUrl != null) 'linkUrl': linkUrl,
    });
  }

  @override
  Future<DiscussionModel> getDiscussionById(String id) {
    return api.getDiscussionById(id);
  }

  @override
  Future<List<ReplyModel>> getReplies(String discussionId) {
    return api.getReplies(discussionId);
  }

  @override
  Future<ReplyModel> createReply(String discussionId, String content, String? parentId) {
    return api.createReply(discussionId, {
      'content': content,
      if (parentId != null) 'parentId': parentId,
    });
  }
}
