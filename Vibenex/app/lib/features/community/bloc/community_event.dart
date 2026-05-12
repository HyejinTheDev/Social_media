part of 'community_bloc.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();
  @override
  List<Object?> get props => [];
}

class LoadCommunitiesRequested extends CommunityEvent {
  final int page;
  final String? search;
  const LoadCommunitiesRequested({this.page = 1, this.search});
  @override
  List<Object?> get props => [page, search];
}

class CreateCommunityRequested extends CommunityEvent {
  final String name;
  final String? description;
  final bool isPublic;
  final Function(String? error)? onResult;

  const CreateCommunityRequested({
    required this.name,
    this.description,
    this.isPublic = true,
    this.onResult,
  });

  @override
  List<Object?> get props => [name, description, isPublic, onResult];
}
