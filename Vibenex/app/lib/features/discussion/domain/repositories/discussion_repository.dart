import '../models/discussion_models.dart';

abstract class DiscussionRepository {
  Future<PaginatedDiscussionsResponse> getDiscussions(String channelId, int page, int limit);
  Future<DiscussionModel> createDiscussion(String channelId, String content, List<String> imageUrls, String? linkUrl);
  Future<DiscussionModel> getDiscussionById(String id);
  Future<List<ReplyModel>> getReplies(String discussionId);
  Future<ReplyModel> createReply(String discussionId, String content, String? parentId);
}
