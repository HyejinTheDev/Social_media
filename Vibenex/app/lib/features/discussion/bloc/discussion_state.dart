part of 'discussion_bloc.dart';

abstract class DiscussionState extends Equatable {
  const DiscussionState();
  @override
  List<Object?> get props => [];
}

class DiscussionInitial extends DiscussionState {}

class DiscussionLoading extends DiscussionState {}

class DiscussionsLoaded extends DiscussionState {
  final String channelId;
  final List<DiscussionModel> discussions;
  final bool hasReachedMax;
  final int currentPage;

  const DiscussionsLoaded({
    required this.channelId,
    required this.discussions,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [channelId, discussions, hasReachedMax, currentPage];

  DiscussionsLoaded copyWith({
    List<DiscussionModel>? discussions,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return DiscussionsLoaded(
      channelId: channelId,
      discussions: discussions ?? this.discussions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class RepliesLoaded extends DiscussionState {
  final String discussionId;
  final DiscussionModel discussion;
  final List<ReplyModel> replies;

  const RepliesLoaded({
    required this.discussionId,
    required this.discussion,
    required this.replies,
  });

  @override
  List<Object?> get props => [discussionId, discussion, replies];
}

class DiscussionError extends DiscussionState {
  final String message;
  const DiscussionError(this.message);
  @override
  List<Object?> get props => [message];
}
