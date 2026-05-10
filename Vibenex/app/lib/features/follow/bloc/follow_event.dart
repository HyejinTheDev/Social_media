part of 'follow_bloc.dart';

abstract class FollowEvent extends Equatable {
  const FollowEvent();
  @override
  List<Object?> get props => [];
}

class FollowToggleRequested extends FollowEvent {
  final String userId;
  const FollowToggleRequested(this.userId);
  @override
  List<Object?> get props => [userId];
}

class FollowCheckStatusRequested extends FollowEvent {
  final String userId;
  const FollowCheckStatusRequested(this.userId);
  @override
  List<Object?> get props => [userId];
}

class FollowLoadFollowersRequested extends FollowEvent {
  final String userId;
  final int page;
  const FollowLoadFollowersRequested({required this.userId, this.page = 1});
  @override
  List<Object?> get props => [userId, page];
}

class FollowLoadFollowingRequested extends FollowEvent {
  final String userId;
  final int page;
  const FollowLoadFollowingRequested({required this.userId, this.page = 1});
  @override
  List<Object?> get props => [userId, page];
}
