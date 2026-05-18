import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../../auth/domain/models/auth_models.dart';
import '../../community/domain/models/community_models.dart';
import '../../profile/data/datasources/profile_api_service.dart';
import '../../community/data/datasources/community_api_service.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final ProfileApiService _profileApi;
  final CommunityApiService _communityApi;
  Timer? _debounce;

  ExploreBloc({
    required ProfileApiService profileApi,
    required CommunityApiService communityApi,
  })  : _profileApi = profileApi,
        _communityApi = communityApi,
        super(const ExploreState()) {
    on<ExploreQueryChanged>(_onQueryChanged);
    on<ExploreSubmitted>(_onSubmit);
    on<ExploreCleared>(_onCleared);
    on<LoadExploreSuggestions>(_onLoadSuggestions);
  }

  Future<void> _onLoadSuggestions(LoadExploreSuggestions event, Emitter<ExploreState> emit) async {
    await _performSearch('', emit);
  }

  Future<void> _onQueryChanged(ExploreQueryChanged event, Emitter<ExploreState> emit) async {
    emit(state.copyWith(query: event.query));

    if (event.query.trim().isEmpty) {
      // Khi xóa hết search, fetch lại gợi ý
      await _performSearch('', emit);
      return;
    }

    // Debounce: wait 400ms
    _debounce?.cancel();
    final completer = Completer<void>();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      completer.complete();
    });

    try {
      await completer.future;
    } catch (_) {
      return;
    }

    await _performSearch(event.query.trim(), emit);
  }

  Future<void> _onSubmit(ExploreSubmitted event, Emitter<ExploreState> emit) async {
    if (event.query.trim().isEmpty) return;
    emit(state.copyWith(query: event.query));
    await _performSearch(event.query.trim(), emit);
  }

  Future<void> _performSearch(String query, Emitter<ExploreState> emit) async {
    emit(state.copyWith(status: ExploreStatus.loading));
    try {
      // Search users and communities in parallel
      final results = await Future.wait([
        _profileApi.searchUsers(query, 1),
        _communityApi.getCommunities(1, 10, query),
      ]);

      final userRes = results[0] as Map<String, dynamic>;
      final communityRes = results[1] as PaginatedCommunitiesResponse;

      final users = (userRes['users'] as List).map((e) => UserModel.fromJson(e)).toList();
      final communities = communityRes.communities;

      emit(state.copyWith(
        status: ExploreStatus.loaded,
        users: users,
        communities: communities,
        total: (userRes['total'] ?? 0) + communities.length,
      ));
    } catch (e) {
      emit(state.copyWith(status: ExploreStatus.error, errorMessage: ErrorMapper.map(e)));
    }
  }

  void _onCleared(ExploreCleared event, Emitter<ExploreState> emit) async {
    emit(const ExploreState());
    await _performSearch('', emit);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
