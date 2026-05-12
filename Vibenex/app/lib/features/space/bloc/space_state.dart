part of 'space_bloc.dart';

abstract class SpaceState extends Equatable {
  const SpaceState();
  @override
  List<Object?> get props => [];
}

class SpaceInitial extends SpaceState {}

class SpaceLoading extends SpaceState {}

class SpaceLoaded extends SpaceState {
  final List<SpaceModel> spaces;
  final bool hasReachedMax;
  final int currentPage;

  const SpaceLoaded({
    required this.spaces,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [spaces, hasReachedMax, currentPage];

  SpaceLoaded copyWith({
    List<SpaceModel>? spaces,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return SpaceLoaded(
      spaces: spaces ?? this.spaces,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class SpaceError extends SpaceState {
  final String message;
  const SpaceError(this.message);
  @override
  List<Object?> get props => [message];
}
