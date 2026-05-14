import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/post_repository.dart';
import 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final PostRepository _postRepository;
  final String postId;

  CommentCubit(this._postRepository, this.postId) : super(CommentInitial());

  Future<void> loadComments() async {
    emit(CommentLoading());
    try {
      final comments = await _postRepository.getComments(postId);
      emit(CommentLoaded(comments));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  Future<void> addComment(String content) async {
    if (state is! CommentLoaded) return;
    
    try {
      final newComment = await _postRepository.createComment(postId, content);
      final currentComments = (state as CommentLoaded).comments;
      emit(CommentLoaded([...currentComments, newComment]));
    } catch (e) {
      // Could emit an error state or a side-effect, but we keep it simple here
    }
  }
}
