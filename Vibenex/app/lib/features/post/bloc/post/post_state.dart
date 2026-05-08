part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostActionLoading extends PostState {}

class PostCreateSuccess extends PostState {
  final PostModel post;
  const PostCreateSuccess(this.post);
  @override
  List<Object?> get props => [post];
}

class PostDeleteSuccess extends PostState {
  final String postId;
  const PostDeleteSuccess(this.postId);
  @override
  List<Object?> get props => [postId];
}

class PostLikeToggleSuccess extends PostState {
  final String postId;
  final bool isLiked;
  const PostLikeToggleSuccess(this.postId, this.isLiked);
  @override
  List<Object?> get props => [postId, isLiked];
}

class PostActionFailure extends PostState {
  final String message;
  const PostActionFailure(this.message);
  @override
  List<Object?> get props => [message];
}
