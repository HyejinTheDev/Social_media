part of 'feed_bloc.dart';

enum FeedStatus { initial, loading, success, failure }

class FeedState extends Equatable {
  final FeedStatus status;
  final List<PostModel> posts;
  final bool hasReachedMax;
  final int currentPage;
  final String? errorMessage;

  const FeedState({
    this.status = FeedStatus.initial,
    this.posts = const <PostModel>[],
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.errorMessage,
  });

  FeedState copyWith({
    FeedStatus? status,
    List<PostModel>? posts,
    bool? hasReachedMax,
    int? currentPage,
    String? errorMessage,
  }) {
    return FeedState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax, currentPage, errorMessage];
}
