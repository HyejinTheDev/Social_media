part of 'space_bloc.dart';

abstract class SpaceEvent extends Equatable {
  const SpaceEvent();
  @override
  List<Object?> get props => [];
}

class LoadSpacesRequested extends SpaceEvent {
  final int page;
  final String? search;
  const LoadSpacesRequested({this.page = 1, this.search});
  @override
  List<Object?> get props => [page, search];
}

class CreateSpaceRequested extends SpaceEvent {
  final String name;
  final String? description;
  final bool isPrivate;
  const CreateSpaceRequested({required this.name, this.description, this.isPrivate = false});
  @override
  List<Object?> get props => [name, description, isPrivate];
}
