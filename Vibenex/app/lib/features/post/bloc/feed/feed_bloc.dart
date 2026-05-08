import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../domain/models/post_models.dart';
import '../../domain/usecases/post_usecases.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedUseCase _getFeed;
  
  FeedBloc({required GetFeedUseCase getFeed})
      : _getFeed = getFeed,
        super(const FeedState()) {
    on<FeedLoadRequested>(_onLoadFeed);
    on<FeedLoadMoreRequested>(_onLoadMore);
    on<FeedRefreshRequested>(_onRefresh);
    on<FeedPostDeleted>(_onPostDeleted);
    on<FeedPostLikeToggled>(_onPostLikeToggled);
  }

  Future<void> _onLoadFeed(FeedLoadRequested event, Emitter<FeedState> emit) async {
    emit(state.copyWith(status: FeedStatus.loading));
    try {
      final response = await _getFeed(page: 1, limit: 10);
      emit(state.copyWith(
        status: FeedStatus.success,
        posts: response.posts,
        hasReachedMax: response.page >= response.totalPages,
        currentPage: 1,
      ));
    } catch (e) {
      emit(state.copyWith(status: FeedStatus.failure, errorMessage: ErrorMapper.map(e)));
    }
  }

  Future<void> _onLoadMore(FeedLoadMoreRequested event, Emitter<FeedState> emit) async {
    if (state.hasReachedMax || state.status != FeedStatus.success) return;
    try {
      final nextPage = state.currentPage + 1;
      final response = await _getFeed(page: nextPage, limit: 10);
      emit(state.copyWith(
        status: FeedStatus.success,
        posts: List.of(state.posts)..addAll(response.posts),
        hasReachedMax: response.page >= response.totalPages,
        currentPage: nextPage,
      ));
    } catch (_) {
      // Handle soft errors or ignore
    }
  }

  Future<void> _onRefresh(FeedRefreshRequested event, Emitter<FeedState> emit) async {
    try {
      final response = await _getFeed(page: 1, limit: 10);
      emit(state.copyWith(
        status: FeedStatus.success,
        posts: response.posts,
        hasReachedMax: response.page >= response.totalPages,
        currentPage: 1,
      ));
    } catch (_) {}
  }

  void _onPostDeleted(FeedPostDeleted event, Emitter<FeedState> emit) {
    if (state.status == FeedStatus.success) {
      final updatedPosts = state.posts.where((p) => p.id != event.postId).toList();
      emit(state.copyWith(posts: updatedPosts));
    }
  }

  void _onPostLikeToggled(FeedPostLikeToggled event, Emitter<FeedState> emit) {
    if (state.status == FeedStatus.success) {
      final updatedPosts = state.posts.map((p) {
        if (p.id == event.postId) {
          return p.copyWith(likesCount: event.isLiked ? p.likesCount + 1 : p.likesCount - 1);
        }
        return p;
      }).toList();
      emit(state.copyWith(posts: updatedPosts));
    }
  }
}
