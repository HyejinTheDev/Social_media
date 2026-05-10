import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../../auth/domain/models/auth_models.dart';
import '../data/datasources/follow_api_service.dart';

part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final FollowApiService _api;

  FollowBloc({required FollowApiService api})
      : _api = api,
        super(const FollowState()) {
    on<FollowToggleRequested>(_onToggle);
    on<FollowLoadFollowersRequested>(_onLoadFollowers);
    on<FollowLoadFollowingRequested>(_onLoadFollowing);
    on<FollowCheckStatusRequested>(_onCheckStatus);
  }

  Future<void> _onToggle(FollowToggleRequested event, Emitter<FollowState> emit) async {
    final wasFollowing = state.followStatusMap[event.userId] ?? false;
    // Optimistic update
    emit(state.copyWith(
      followStatusMap: {...state.followStatusMap, event.userId: !wasFollowing},
    ));

    try {
      if (wasFollowing) {
        await _api.unfollow(event.userId);
      } else {
        await _api.follow(event.userId);
      }
    } catch (e) {
      // Revert on failure
      emit(state.copyWith(
        followStatusMap: {...state.followStatusMap, event.userId: wasFollowing},
        errorMessage: ErrorMapper.map(e),
      ));
    }
  }

  Future<void> _onCheckStatus(FollowCheckStatusRequested event, Emitter<FollowState> emit) async {
    try {
      final res = await _api.getFollowStatus(event.userId);
      emit(state.copyWith(
        followStatusMap: {...state.followStatusMap, event.userId: res['following'] == true},
      ));
    } catch (_) {}
  }

  Future<void> _onLoadFollowers(FollowLoadFollowersRequested event, Emitter<FollowState> emit) async {
    emit(state.copyWith(listStatus: FollowListStatus.loading));
    try {
      final res = await _api.getFollowers(event.userId, event.page);
      final users = (res['users'] as List).map((e) => UserModel.fromJson(e)).toList();
      emit(state.copyWith(
        listStatus: FollowListStatus.loaded,
        users: event.page == 1 ? users : [...state.users, ...users],
        total: res['total'] ?? 0,
        currentPage: event.page,
        totalPages: res['totalPages'] ?? 1,
      ));
    } catch (e) {
      emit(state.copyWith(listStatus: FollowListStatus.error, errorMessage: ErrorMapper.map(e)));
    }
  }

  Future<void> _onLoadFollowing(FollowLoadFollowingRequested event, Emitter<FollowState> emit) async {
    emit(state.copyWith(listStatus: FollowListStatus.loading));
    try {
      final res = await _api.getFollowing(event.userId, event.page);
      final users = (res['users'] as List).map((e) => UserModel.fromJson(e)).toList();
      emit(state.copyWith(
        listStatus: FollowListStatus.loaded,
        users: event.page == 1 ? users : [...state.users, ...users],
        total: res['total'] ?? 0,
        currentPage: event.page,
        totalPages: res['totalPages'] ?? 1,
      ));
    } catch (e) {
      emit(state.copyWith(listStatus: FollowListStatus.error, errorMessage: ErrorMapper.map(e)));
    }
  }
}
