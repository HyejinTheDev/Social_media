import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../domain/models/discussion_models.dart';
import '../domain/repositories/discussion_repository.dart';

part 'discussion_event.dart';
part 'discussion_state.dart';

class DiscussionBloc extends Bloc<DiscussionEvent, DiscussionState> {
  final DiscussionRepository _repository;

  DiscussionBloc({required DiscussionRepository repository})
      : _repository = repository,
        super(DiscussionInitial()) {
    on<LoadDiscussionsRequested>(_onLoadDiscussions);
    on<CreateDiscussionRequested>(_onCreateDiscussion);
    on<LoadRepliesRequested>(_onLoadReplies);
    on<CreateReplyRequested>(_onCreateReply);
  }

  Future<void> _onLoadDiscussions(
    LoadDiscussionsRequested event,
    Emitter<DiscussionState> emit,
  ) async {
    try {
      if (event.page == 1) {
        emit(DiscussionLoading());
      } else if (state is DiscussionsLoaded &&
          (state as DiscussionsLoaded).hasReachedMax) {
        return;
      }

      final res = await _repository.getDiscussions(event.channelId, event.page, 20);

      if (state is DiscussionsLoaded && event.page > 1) {
        final current = state as DiscussionsLoaded;
        emit(current.copyWith(
          discussions: current.discussions + res.discussions,
          hasReachedMax: res.discussions.length < 20,
          currentPage: event.page,
        ));
      } else {
        emit(DiscussionsLoaded(
          channelId: event.channelId,
          discussions: res.discussions,
          hasReachedMax: res.discussions.length < 20,
          currentPage: 1,
        ));
      }
    } catch (e) {
      if (event.page == 1) {
        emit(DiscussionError(ErrorMapper.map(e)));
      }
    }
  }

  Future<void> _onCreateDiscussion(
    CreateDiscussionRequested event,
    Emitter<DiscussionState> emit,
  ) async {
    try {
      final newDiscussion = await _repository.createDiscussion(
        event.channelId,
        event.content,
        event.imageUrls,
        event.linkUrl,
      );
      if (state is DiscussionsLoaded) {
        final current = state as DiscussionsLoaded;
        emit(current.copyWith(
          discussions: [newDiscussion, ...current.discussions],
        ));
      }
    } catch (e) {
      // Silently fail – the UI can show a toast separately
    }
  }

  Future<void> _onLoadReplies(
    LoadRepliesRequested event,
    Emitter<DiscussionState> emit,
  ) async {
    emit(DiscussionLoading());
    try {
      final discussion = await _repository.getDiscussionById(event.discussionId);
      final replies = await _repository.getReplies(event.discussionId);
      emit(RepliesLoaded(
        discussionId: event.discussionId,
        discussion: discussion,
        replies: replies,
      ));
    } catch (e) {
      emit(DiscussionError(ErrorMapper.map(e)));
    }
  }

  Future<void> _onCreateReply(
    CreateReplyRequested event,
    Emitter<DiscussionState> emit,
  ) async {
    try {
      final newReply = await _repository.createReply(
        event.discussionId,
        event.content,
        event.parentId,
      );
      if (state is RepliesLoaded) {
        final current = state as RepliesLoaded;
        emit(RepliesLoaded(
          discussionId: current.discussionId,
          discussion: current.discussion.copyWith(
            replyCount: current.discussion.replyCount + 1,
          ),
          replies: [...current.replies, newReply],
        ));
      }
    } catch (e) {
      // Silently fail
    }
  }
}
