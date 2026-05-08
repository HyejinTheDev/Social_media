part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
  @override
  List<Object?> get props => [];
}

class CommentLoadRequested extends CommentEvent {
  final String postId;
  const CommentLoadRequested(this.postId);
  @override
  List<Object?> get props => [postId];
}

class CommentLoadMoreRequested extends CommentEvent {}

class CommentAddRequested extends CommentEvent {
  final String postId;
  final String content;
  const CommentAddRequested(this.postId, this.content);
  @override
  List<Object?> get props => [postId, content];
}

class CommentDeleteRequested extends CommentEvent {
  final String commentId;
  const CommentDeleteRequested(this.commentId);
  @override
  List<Object?> get props => [commentId];
}
