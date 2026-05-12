import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../domain/models/space_models.dart';
import '../domain/repositories/space_repository.dart';

part 'space_event.dart';
part 'space_state.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  final SpaceRepository _repository;

  SpaceBloc({required SpaceRepository repository})
      : _repository = repository,
        super(SpaceInitial()) {
    on<LoadSpacesRequested>(_onLoadSpaces);
    on<CreateSpaceRequested>(_onCreateSpace);
  }

  Future<void> _onLoadSpaces(LoadSpacesRequested event, Emitter<SpaceState> emit) async {
    try {
      if (event.page == 1) {
        emit(SpaceLoading());
      } else if (state is SpaceLoaded && (state as SpaceLoaded).hasReachedMax) {
        return;
      }

      final res = await _repository.getSpaces(event.page, 20, event.search);
      
      if (state is SpaceLoaded && event.page > 1) {
        final currentSpaces = (state as SpaceLoaded).spaces;
        emit(SpaceLoaded(
          spaces: currentSpaces + res.spaces,
          hasReachedMax: res.spaces.isEmpty || res.spaces.length < 20,
          currentPage: event.page,
        ));
      } else {
        emit(SpaceLoaded(
          spaces: res.spaces,
          hasReachedMax: res.spaces.isEmpty || res.spaces.length < 20,
          currentPage: 1,
        ));
      }
    } catch (e) {
      if (event.page == 1) {
        emit(SpaceError(ErrorMapper.map(e)));
      }
    }
  }

  Future<void> _onCreateSpace(CreateSpaceRequested event, Emitter<SpaceState> emit) async {
    try {
      final newSpace = await _repository.createSpace(event.name, event.description, event.isPrivate);
      if (state is SpaceLoaded) {
        final current = state as SpaceLoaded;
        emit(current.copyWith(spaces: [newSpace, ...current.spaces]));
      }
    } catch (e) {
      // Just emit an error but keep the current state, maybe use a toast in UI
      // In a real app we might use a separate bloc or listen for CreateSuccess
    }
  }
}
