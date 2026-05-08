part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class PostCreateRequested extends PostEvent {
  final String content;
  final List<File>? images;
  final File? video;
  final File? thumbnail;

  const PostCreateRequested({required this.content, this.images, this.video, this.thumbnail});

  @override
  List<Object?> get props => [content, images, video, thumbnail];
}

class PostDeleteRequested extends PostEvent {
  final String postId;
  const PostDeleteRequested(this.postId);

  @override
  List<Object?> get props => [postId];
}

class PostToggleLikeRequested extends PostEvent {
  final String postId;
  const PostToggleLikeRequested(this.postId);

  @override
  List<Object?> get props => [postId];
}
