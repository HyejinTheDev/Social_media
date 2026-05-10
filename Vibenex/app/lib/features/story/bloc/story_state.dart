part of 'story_bloc.dart';

enum StoryStatus { initial, loading, success, failure }
enum StoryCreateStatus { initial, loading, success, failure }

class StoryState extends Equatable {
  final StoryStatus status;
  final StoryCreateStatus createStatus;
  final List<StoryGroup> groups;
  final String? errorMessage;

  const StoryState({
    this.status = StoryStatus.initial,
    this.createStatus = StoryCreateStatus.initial,
    this.groups = const [],
    this.errorMessage,
  });

  StoryState copyWith({
    StoryStatus? status,
    StoryCreateStatus? createStatus,
    List<StoryGroup>? groups,
    String? errorMessage,
  }) {
    return StoryState(
      status: status ?? this.status,
      createStatus: createStatus ?? this.createStatus,
      groups: groups ?? this.groups,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, createStatus, groups, errorMessage];
}
