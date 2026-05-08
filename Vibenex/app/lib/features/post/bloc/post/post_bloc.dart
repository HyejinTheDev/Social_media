import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../domain/models/post_models.dart';
import '../../domain/usecases/post_usecases.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePostUseCase _createPost;
  final DeletePostUseCase _deletePost;
  final ToggleLikeUseCase _toggleLike;

  PostBloc({
    required CreatePostUseCase createPost,
    required DeletePostUseCase deletePost,
    required ToggleLikeUseCase toggleLike,
  })  : _createPost = createPost,
        _deletePost = deletePost,
        _toggleLike = toggleLike,
        super(PostInitial()) {
    on<PostCreateRequested>(_onCreatePost);
    on<PostDeleteRequested>(_onDeletePost);
    on<PostToggleLikeRequested>(_onToggleLike);
  }

  Future<void> _onCreatePost(PostCreateRequested event, Emitter<PostState> emit) async {
    emit(PostActionLoading());
    try {
      final post = await _createPost(
        content: event.content,
        images: event.images,
        video: event.video,
        thumbnail: event.thumbnail,
      );
      emit(PostCreateSuccess(post));
    } catch (e) {
      emit(PostActionFailure(ErrorMapper.map(e)));
    }
  }

  Future<void> _onDeletePost(PostDeleteRequested event, Emitter<PostState> emit) async {
    emit(PostActionLoading());
    try {
      await _deletePost(event.postId);
      emit(PostDeleteSuccess(event.postId));
    } catch (e) {
      emit(PostActionFailure(ErrorMapper.map(e)));
    }
  }

  Future<void> _onToggleLike(PostToggleLikeRequested event, Emitter<PostState> emit) async {
    // Fire and forget optimistic update, the actual like logic is handled here 
    // and FeedBloc updates its list, but we still handle failures if needed.
    try {
      final isLiked = await _toggleLike(event.postId);
      emit(PostLikeToggleSuccess(event.postId, isLiked));
    } catch (e) {
      emit(PostActionFailure(ErrorMapper.map(e)));
    }
  }
}
