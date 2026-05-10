import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../../auth/domain/models/auth_models.dart';
import '../domain/repositories/profile_repository.dart';
import '../../follow/data/datasources/follow_api_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  final FollowApiService _followApi;

  ProfileBloc({required ProfileRepository repository, required FollowApiService followApi})
      : _repository = repository,
        _followApi = followApi,
        super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onLoad);
    on<ProfileUpdateRequested>(_onUpdate);
    on<ProfileAvatarUploadRequested>(_onAvatarUpload);
    on<ProfileCoverUploadRequested>(_onCoverUpload);
    on<ProfileFollowToggled>(_onFollowToggle);
  }

  Future<void> _onLoad(ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      if (event.userId == null) {
        final user = await _repository.getMyProfile();
        emit(ProfileLoaded(user: user, isOwnProfile: true));
      } else {
        final data = await _repository.getUserById(event.userId!);
        final user = UserModel.fromJson(data);
        emit(ProfileLoaded(
          user: user,
          isOwnProfile: data['isOwnProfile'] == true,
          isFollowing: data['isFollowing'] == true,
        ));
      }
    } catch (e) {
      emit(ProfileError(ErrorMapper.map(e)));
    }
  }

  Future<void> _onUpdate(ProfileUpdateRequested event, Emitter<ProfileState> emit) async {
    final current = state;
    if (current is! ProfileLoaded) return;
    emit(ProfileUpdating(current.user));
    try {
      final user = await _repository.updateProfile(
        name: event.name,
        username: event.username,
        bio: event.bio,
      );
      emit(ProfileLoaded(user: user, isOwnProfile: true));
    } catch (e) {
      emit(ProfileError(ErrorMapper.map(e)));
      emit(ProfileLoaded(user: current.user, isOwnProfile: true));
    }
  }

  Future<void> _onAvatarUpload(ProfileAvatarUploadRequested event, Emitter<ProfileState> emit) async {
    final current = state;
    if (current is! ProfileLoaded) return;
    emit(ProfileUpdating(current.user));
    try {
      final user = await _repository.uploadAvatar(File(event.filePath));
      emit(ProfileLoaded(user: user, isOwnProfile: true));
    } catch (e) {
      emit(ProfileError(ErrorMapper.map(e)));
      emit(ProfileLoaded(user: current.user, isOwnProfile: true));
    }
  }

  Future<void> _onCoverUpload(ProfileCoverUploadRequested event, Emitter<ProfileState> emit) async {
    final current = state;
    if (current is! ProfileLoaded) return;
    emit(ProfileUpdating(current.user));
    try {
      final user = await _repository.uploadCover(File(event.filePath));
      emit(ProfileLoaded(user: user, isOwnProfile: true));
    } catch (e) {
      emit(ProfileError(ErrorMapper.map(e)));
      emit(ProfileLoaded(user: current.user, isOwnProfile: true));
    }
  }

  Future<void> _onFollowToggle(ProfileFollowToggled event, Emitter<ProfileState> emit) async {
    final current = state;
    if (current is! ProfileLoaded) return;

    final wasFollowing = current.isFollowing;
    // Optimistic UI update
    emit(current.copyWith(
      isFollowing: !wasFollowing,
      user: current.user.copyWith(
        followersCount: current.user.followersCount + (wasFollowing ? -1 : 1),
      ),
    ));

    try {
      if (wasFollowing) {
        await _followApi.unfollow(event.userId);
      } else {
        await _followApi.follow(event.userId);
      }
    } catch (e) {
      // Revert on failure
      emit(current.copyWith(isFollowing: wasFollowing));
    }
  }
}
