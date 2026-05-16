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
  final bool isVoiceRoom;
  final Function(String? error)? onResult;

  const CreateCommunityRequested({
    required this.name,
    this.description,
    this.isPublic = true,
    this.isVoiceRoom = false,
    this.onResult,
  });

  @override
  List<Object?> get props => [name, description, isPublic, isVoiceRoom, onResult];
}

class LeaveCommunityRequested extends CommunityEvent {
  final String communityId;
  final Function(String? error)? onResult;
  const LeaveCommunityRequested({required this.communityId, this.onResult});
  @override
  List<Object?> get props => [communityId, onResult];
}

class DeleteCommunityRequested extends CommunityEvent {
  final String communityId;
  final Function(String? error)? onResult;
  const DeleteCommunityRequested({required this.communityId, this.onResult});
  @override
  List<Object?> get props => [communityId, onResult];
}
