import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../../auth/domain/models/auth_models.dart';
import '../../follow/data/datasources/follow_api_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FollowApiService _api;
  Timer? _debounce;

  SearchBloc({required FollowApiService api})
      : _api = api,
        super(const SearchState()) {
    on<SearchQueryChanged>(_onQueryChanged);
    on<SearchSubmitted>(_onSubmit);
    on<SearchCleared>(_onCleared);
  }

  Future<void> _onQueryChanged(SearchQueryChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(query: event.query));

    if (event.query.trim().isEmpty) {
      emit(state.copyWith(status: SearchStatus.initial, users: []));
      return;
    }

    // Debounce: wait 300ms
    _debounce?.cancel();
    final completer = Completer<void>();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      completer.complete();
    });

    try {
      await completer.future;
    } catch (_) {
      return;
    }

    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final res = await _api.searchUsers(event.query.trim(), 1);
      final users = (res['users'] as List).map((e) => UserModel.fromJson(e)).toList();
      emit(state.copyWith(
        status: SearchStatus.loaded,
        users: users,
        total: res['total'] ?? 0,
      ));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.error, errorMessage: ErrorMapper.map(e)));
    }
  }

  Future<void> _onSubmit(SearchSubmitted event, Emitter<SearchState> emit) async {
    if (event.query.trim().isEmpty) return;
    emit(state.copyWith(status: SearchStatus.loading, query: event.query));
    try {
      final res = await _api.searchUsers(event.query.trim(), 1);
      final users = (res['users'] as List).map((e) => UserModel.fromJson(e)).toList();
      emit(state.copyWith(
        status: SearchStatus.loaded,
        users: users,
        total: res['total'] ?? 0,
      ));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.error, errorMessage: ErrorMapper.map(e)));
    }
  }

  void _onCleared(SearchCleared event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
