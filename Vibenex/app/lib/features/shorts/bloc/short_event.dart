import 'package:equatable/equatable.dart';

abstract class ShortEvent extends Equatable {
  const ShortEvent();

  @override
  List<Object?> get props => [];
}

class LoadShorts extends ShortEvent {
  final String currentUserId;
  const LoadShorts(this.currentUserId);
  @override
  List<Object?> get props => [currentUserId];
}

class LoadMoreShorts extends ShortEvent {
  final String currentUserId;
  const LoadMoreShorts(this.currentUserId);
  @override
  List<Object?> get props => [currentUserId];
}

class ToggleLikeShort extends ShortEvent {
  final String shortId;
  const ToggleLikeShort(this.shortId);
  @override
  List<Object?> get props => [shortId];
}
