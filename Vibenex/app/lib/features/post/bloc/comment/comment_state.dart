part of 'comment_bloc.dart';

enum CommentStatus { initial, loading, success, failure }

class CommentState extends Equatable {
  final CommentStatus status;
  final String? postId;
  final List<CommentModel> comments;
  final bool hasReachedMax;
  final int currentPage;
  final String? errorMessage;

  const CommentState({
    this.status = CommentStatus.initial,
    this.postId,
    this.comments = const <CommentModel>[],
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.errorMessage,
  });

  CommentState copyWith({
    CommentStatus? status,
    String? postId,
    List<CommentModel>? comments,
    bool? hasReachedMax,
    int? currentPage,
    String? errorMessage,
  }) {
    return CommentState(
      status: status ?? this.status,
      postId: postId ?? this.postId,
      comments: comments ?? this.comments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, postId, comments, hasReachedMax, currentPage, errorMessage];
}
