import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/short_repository.dart';
import 'short_event.dart';
import 'short_state.dart';

export 'short_event.dart';
export 'short_state.dart';

class ShortBloc extends Bloc<ShortEvent, ShortState> {
  final ShortRepository _repository;

  ShortBloc({required ShortRepository repository})
      : _repository = repository,
        super(const ShortState()) {
    on<LoadShorts>(_onLoadShorts);
    on<LoadMoreShorts>(_onLoadMoreShorts);
    on<ToggleLikeShort>(_onToggleLikeShort);
  }

  Future<void> _onLoadShorts(LoadShorts event, Emitter<ShortState> emit) async {
    emit(state.copyWith(status: ShortStatus.loading));
    try {
      final shorts = await _repository.getFeed(1, event.currentUserId);
      emit(state.copyWith(
        status: ShortStatus.loaded,
        shorts: shorts,
        page: 1,
        hasMore: shorts.length == 10,
      ));
    } catch (e) {
      emit(state.copyWith(status: ShortStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onLoadMoreShorts(LoadMoreShorts event, Emitter<ShortState> emit) async {
    if (!state.hasMore || state.status == ShortStatus.loading) return;

    final nextPage = state.page + 1;
    try {
      final shorts = await _repository.getFeed(nextPage, event.currentUserId);
      emit(state.copyWith(
        shorts: [...state.shorts, ...shorts],
        page: nextPage,
        hasMore: shorts.length == 10,
      ));
    } catch (_) {}
  }

  Future<void> _onToggleLikeShort(ToggleLikeShort event, Emitter<ShortState> emit) async {
    final originalShorts = List.of(state.shorts);
    final index = originalShorts.indexWhere((s) => s.id == event.shortId);
    if (index == -1) return;

    final short = originalShorts[index];
    final isLiked = short.isLikedByMe;
    
    // Optimistic update
    originalShorts[index] = short.copyWith(
      isLikedByMe: !isLiked,
      likeCount: isLiked ? short.likeCount - 1 : short.likeCount + 1,
    );
    emit(state.copyWith(shorts: originalShorts));

    try {
      final result = await _repository.toggleLike(event.shortId);
      if (result != !isLiked) {
        // Revert if mismatch
        originalShorts[index] = short.copyWith(
          isLikedByMe: result,
          likeCount: result ? short.likeCount + 1 : short.likeCount - 1,
        );
        emit(state.copyWith(shorts: originalShorts));
      }
    } catch (_) {
      // Revert on error
      originalShorts[index] = short;
      emit(state.copyWith(shorts: originalShorts));
    }
  }
}
