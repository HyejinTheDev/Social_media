part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();
  @override
  List<Object?> get props => [];
}

class FeedLoadRequested extends FeedEvent {}
class FeedLoadMoreRequested extends FeedEvent {}
class FeedRefreshRequested extends FeedEvent {}

class FeedPostDeleted extends FeedEvent {
  final String postId;
  const FeedPostDeleted(this.postId);
  @override
  List<Object?> get props => [postId];
}

class FeedPostLikeToggled extends FeedEvent {
  final String postId;
  final bool isLiked;
  const FeedPostLikeToggled(this.postId, this.isLiked);
  @override
  List<Object?> get props => [postId, isLiked];
}
