part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  final String? userId; // null = my profile
  const ProfileLoadRequested({this.userId});
  @override
  List<Object?> get props => [userId];
}

class ProfileUpdateRequested extends ProfileEvent {
  final String? name;
  final String? username;
  final String? bio;
  const ProfileUpdateRequested({this.name, this.username, this.bio});
  @override
  List<Object?> get props => [name, username, bio];
}

class ProfileAvatarUploadRequested extends ProfileEvent {
  final String filePath;
  const ProfileAvatarUploadRequested(this.filePath);
  @override
  List<Object?> get props => [filePath];
}

class ProfileCoverUploadRequested extends ProfileEvent {
  final String filePath;
  const ProfileCoverUploadRequested(this.filePath);
  @override
  List<Object?> get props => [filePath];
}

class ProfileFollowToggled extends ProfileEvent {
  final String userId;
  const ProfileFollowToggled(this.userId);
  @override
  List<Object?> get props => [userId];
}

class ProfileFriendRequestSent extends ProfileEvent {
  final String userId;
  const ProfileFriendRequestSent(this.userId);
  @override
  List<Object?> get props => [userId];
}
