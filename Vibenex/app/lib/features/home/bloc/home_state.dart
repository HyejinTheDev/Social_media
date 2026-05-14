import 'package:equatable/equatable.dart';
import '../domain/models/home_models.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<PostModel> posts;
  final List<StoryModel> stories;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.posts = const [],
    this.stories = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<PostModel>? posts,
    List<StoryModel>? stories,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      stories: stories ?? this.stories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, posts, stories, errorMessage];
}
