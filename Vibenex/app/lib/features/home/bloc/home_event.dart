import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoadRequested extends HomeEvent {}

class HomeRefreshed extends HomeEvent {}

class HomePostLikeToggled extends HomeEvent {
  final String postId;

  const HomePostLikeToggled(this.postId);

  @override
  List<Object?> get props => [postId];
}

class HomePostCreated extends HomeEvent {
  final String content;
  final List<File>? images;
  final File? video;

  const HomePostCreated({
    required this.content,
    this.images,
    this.video,
  });

  @override
  List<Object?> get props => [content, images, video];
}

class HomeStoryCreated extends HomeEvent {
  final File file;

  const HomeStoryCreated({required this.file});

  @override
  List<Object?> get props => [file];
}
