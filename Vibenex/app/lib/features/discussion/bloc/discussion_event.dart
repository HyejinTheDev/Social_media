part of 'discussion_bloc.dart';

abstract class DiscussionEvent extends Equatable {
  const DiscussionEvent();
  @override
  List<Object?> get props => [];
}

/// Load discussions for a channel.
class LoadDiscussionsRequested extends DiscussionEvent {
  final String channelId;
  final int page;
  const LoadDiscussionsRequested({required this.channelId, this.page = 1});
  @override
  List<Object?> get props => [channelId, page];
}

/// Create a new discussion in a channel.
class CreateDiscussionRequested extends DiscussionEvent {
  final String channelId;
  final String content;
  final List<String> imageUrls;
  final String? linkUrl;
  const CreateDiscussionRequested({
    required this.channelId,
    required this.content,
    this.imageUrls = const [],
    this.linkUrl,
  });
  @override
  List<Object?> get props => [channelId, content, imageUrls, linkUrl];
}

/// Load replies for a discussion.
class LoadRepliesRequested extends DiscussionEvent {
  final String discussionId;
  const LoadRepliesRequested({required this.discussionId});
  @override
  List<Object?> get props => [discussionId];
}

/// Create a reply to a discussion.
class CreateReplyRequested extends DiscussionEvent {
  final String discussionId;
  final String content;
  final String? parentId;
  const CreateReplyRequested({
    required this.discussionId,
    required this.content,
    this.parentId,
  });
  @override
  List<Object?> get props => [discussionId, content, parentId];
}
