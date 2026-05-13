import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../../auth/domain/models/auth_models.dart';
import '../../profile/data/datasources/profile_api_service.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final ProfileApiService _api;
  Timer? _debounce;

  ExploreBloc({required ProfileApiService api})
      : _api = api,
        super(const ExploreState()) {
    on<ExploreQueryChanged>(_onQueryChanged);
    on<ExploreSubmitted>(_onSubmit);
    on<ExploreCleared>(_onCleared);
  }

  Future<void> _onQueryChanged(ExploreQueryChanged event, Emitter<ExploreState> emit) async {
    emit(state.copyWith(query: event.query));

    if (event.query.trim().isEmpty) {
      emit(state.copyWith(status: ExploreStatus.initial, users: []));
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

    emit(state.copyWith(status: ExploreStatus.loading));
    try {
      final res = await _api.searchUsers(event.query.trim(), 1);
      final users = (res['users'] as List).map((e) => UserModel.fromJson(e)).toList();
      emit(state.copyWith(
        status: ExploreStatus.loaded,
        users: users,
        total: res['total'] ?? 0,
      ));
    } catch (e) {
      emit(state.copyWith(status: ExploreStatus.error, errorMessage: ErrorMapper.map(e)));
    }
  }

  Future<void> _onSubmit(ExploreSubmitted event, Emitter<ExploreState> emit) async {
    if (event.query.trim().isEmpty) return;
    emit(state.copyWith(status: ExploreStatus.loading, query: event.query));
    try {
      final res = await _api.searchUsers(event.query.trim(), 1);
      final users = (res['users'] as List).map((e) => UserModel.fromJson(e)).toList();
      emit(state.copyWith(
        status: ExploreStatus.loaded,
        users: users,
        total: res['total'] ?? 0,
      ));
    } catch (e) {
      emit(state.copyWith(status: ExploreStatus.error, errorMessage: ErrorMapper.map(e)));
    }
  }

  void _onCleared(ExploreCleared event, Emitter<ExploreState> emit) {
    emit(const ExploreState());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
