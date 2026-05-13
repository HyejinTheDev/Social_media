part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();
  @override
  List<Object?> get props => [];
}

class ExploreQueryChanged extends ExploreEvent {
  final String query;
  const ExploreQueryChanged(this.query);
  @override
  List<Object?> get props => [query];
}

class ExploreSubmitted extends ExploreEvent {
  final String query;
  const ExploreSubmitted(this.query);
  @override
  List<Object?> get props => [query];
}

class ExploreCleared extends ExploreEvent {
  const ExploreCleared();
}
