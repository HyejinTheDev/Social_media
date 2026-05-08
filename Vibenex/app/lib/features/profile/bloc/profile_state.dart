part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final bool isOwnProfile;
  final bool isFollowing;

  const ProfileLoaded({
    required this.user,
    this.isOwnProfile = true,
    this.isFollowing = false,
  });

  @override
  List<Object?> get props => [user, isOwnProfile, isFollowing];

  ProfileLoaded copyWith({UserModel? user, bool? isOwnProfile, bool? isFollowing}) {
    return ProfileLoaded(
      user: user ?? this.user,
      isOwnProfile: isOwnProfile ?? this.isOwnProfile,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}

class ProfileUpdating extends ProfileState {
  final UserModel user;
  const ProfileUpdating(this.user);
  @override
  List<Object?> get props => [user];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object?> get props => [message];
}
