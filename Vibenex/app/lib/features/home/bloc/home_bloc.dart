import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/home_mock_data.dart';
import 'home_event.dart';
import 'home_state.dart';

import '../domain/repositories/post_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostRepository _postRepository;

  HomeBloc(this._postRepository) : super(const HomeState()) {
    on<HomeLoadRequested>(_onLoadRequested);
    on<HomeRefreshed>(_onRefreshed);
    on<HomePostLikeToggled>(_onPostLikeToggled);
    on<HomePostCreated>(_onPostCreated);
  }

  Future<void> _onLoadRequested(HomeLoadRequested event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    
    try {
      final posts = await _postRepository.getFeed(page: 1, limit: 10);
      emit(state.copyWith(
        status: HomeStatus.loaded,
        posts: posts,
        stories: HomeMockData.stories, // Keep stories mock for now
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onRefreshed(HomeRefreshed event, Emitter<HomeState> emit) async {
    try {
      final posts = await _postRepository.getFeed(page: 1, limit: 10);
      emit(state.copyWith(
        status: HomeStatus.loaded,
        posts: posts,
        stories: HomeMockData.stories,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onPostLikeToggled(HomePostLikeToggled event, Emitter<HomeState> emit) async {
    if (state.status != HomeStatus.loaded) return;

    final updatedPosts = state.posts.map((post) {
      if (post.id == event.postId) {
        final isLiked = !post.isLiked;
        final likeCount = isLiked ? post.likeCount + 1 : post.likeCount - 1;
        return post.copyWith(isLiked: isLiked, likeCount: likeCount);
      }
      return post;
    }).toList();

    emit(state.copyWith(posts: updatedPosts));

    // Call API in background
    try {
      await _postRepository.toggleLike(event.postId);
    } catch (e) {
      // Revert if failed
      add(HomeLoadRequested());
    }
  }

  Future<void> _onPostCreated(HomePostCreated event, Emitter<HomeState> emit) async {
    try {
      List<String>? uploadedImageUrls;
      String? uploadedVideoUrl;

      // Upload images if any
      if (event.images != null && event.images!.isNotEmpty) {
        uploadedImageUrls = [];
        for (final file in event.images!) {
          final url = await _postRepository.uploadMedia(file);
          uploadedImageUrls.add(url);
        }
      }

      // Upload video if any
      if (event.video != null) {
        uploadedVideoUrl = await _postRepository.uploadMedia(event.video!);
      }

      final newPost = await _postRepository.createPost(
        content: event.content,
        imageUrls: uploadedImageUrls,
        videoUrl: uploadedVideoUrl,
      );
      
      final updatedPosts = [newPost, ...state.posts];
      emit(state.copyWith(posts: updatedPosts));
    } catch (e) {
      // Handle error
    }
  }
}
