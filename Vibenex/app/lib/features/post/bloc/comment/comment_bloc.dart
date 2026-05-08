import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../domain/models/post_models.dart';
import '../../domain/usecases/post_usecases.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentsUseCase _getComments;
  final AddCommentUseCase _addComment;
  final DeleteCommentUseCase _deleteComment;

  CommentBloc({
    required GetCommentsUseCase getComments,
    required AddCommentUseCase addComment,
    required DeleteCommentUseCase deleteComment,
  })  : _getComments = getComments,
        _addComment = addComment,
        _deleteComment = deleteComment,
        super(const CommentState()) {
    on<CommentLoadRequested>(_onLoadComments);
    on<CommentLoadMoreRequested>(_onLoadMore);
    on<CommentAddRequested>(_onAddComment);
    on<CommentDeleteRequested>(_onDeleteComment);
  }

  Future<void> _onLoadComments(CommentLoadRequested event, Emitter<CommentState> emit) async {
    emit(state.copyWith(status: CommentStatus.loading));
    try {
      final response = await _getComments(event.postId, page: 1, limit: 20);
      emit(state.copyWith(
        status: CommentStatus.success,
        postId: event.postId,
        comments: response.comments,
        hasReachedMax: response.page >= response.totalPages,
        currentPage: 1,
      ));
    } catch (e) {
      emit(state.copyWith(status: CommentStatus.failure, errorMessage: ErrorMapper.map(e)));
    }
  }

  Future<void> _onLoadMore(CommentLoadMoreRequested event, Emitter<CommentState> emit) async {
    if (state.hasReachedMax || state.status != CommentStatus.success || state.postId == null) return;
    try {
      final nextPage = state.currentPage + 1;
      final response = await _getComments(state.postId!, page: nextPage, limit: 20);
      emit(state.copyWith(
        status: CommentStatus.success,
        comments: List.of(state.comments)..addAll(response.comments),
        hasReachedMax: response.page >= response.totalPages,
        currentPage: nextPage,
      ));
    } catch (_) {}
  }

  Future<void> _onAddComment(CommentAddRequested event, Emitter<CommentState> emit) async {
    // Optimistic UI could be implemented here
    try {
      final comment = await _addComment(event.postId, event.content);
      if (state.status == CommentStatus.success && state.postId == event.postId) {
        emit(state.copyWith(comments: [comment, ...state.comments]));
      }
    } catch (e) {
      // Revert if optimistic UI was implemented
    }
  }

  Future<void> _onDeleteComment(CommentDeleteRequested event, Emitter<CommentState> emit) async {
    try {
      await _deleteComment(event.commentId);
      if (state.status == CommentStatus.success) {
        final updatedComments = state.comments.where((c) => c.id != event.commentId).toList();
        emit(state.copyWith(comments: updatedComments));
      }
    } catch (e) {
      // Error handling
    }
  }
}
