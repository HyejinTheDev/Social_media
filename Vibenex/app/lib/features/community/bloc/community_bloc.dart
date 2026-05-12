import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../domain/models/community_models.dart';
import '../domain/repositories/community_repository.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final CommunityRepository _repository;

  CommunityBloc({required CommunityRepository repository})
      : _repository = repository,
        super(CommunityInitial()) {
    on<LoadCommunitiesRequested>(_onLoadCommunities);
    on<CreateCommunityRequested>(_onCreateCommunity);
  }

  Future<void> _onLoadCommunities(LoadCommunitiesRequested event, Emitter<CommunityState> emit) async {
    try {
      if (event.page == 1) {
        emit(CommunityLoading());
      } else if (state is CommunityLoaded && (state as CommunityLoaded).hasReachedMax) {
        return;
      }

      final res = await _repository.getCommunities(event.page, 20, event.search);

      if (state is CommunityLoaded && event.page > 1) {
        final current = (state as CommunityLoaded).communities;
        emit(CommunityLoaded(
          communities: current + res.communities,
          hasReachedMax: res.communities.isEmpty || res.communities.length < 20,
          currentPage: event.page,
        ));
      } else {
        emit(CommunityLoaded(
          communities: res.communities,
          hasReachedMax: res.communities.isEmpty || res.communities.length < 20,
          currentPage: 1,
        ));
      }
    } catch (e) {
      if (event.page == 1) {
        emit(CommunityError(ErrorMapper.map(e)));
      }
    }
  }

  Future<void> _onCreateCommunity(CreateCommunityRequested event, Emitter<CommunityState> emit) async {
    try {
      final newCommunity = await _repository.createCommunity(event.name, event.description, event.isPublic);
      if (state is CommunityLoaded) {
        final current = state as CommunityLoaded;
        emit(current.copyWith(communities: [newCommunity, ...current.communities]));
      }
      event.onResult?.call(null);
    } catch (e) {
      event.onResult?.call(ErrorMapper.map(e));
    }
  }
}
