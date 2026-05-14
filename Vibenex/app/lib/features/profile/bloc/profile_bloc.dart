import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../../auth/domain/models/auth_models.dart';
import '../../home/domain/models/home_models.dart';
import '../domain/repositories/profile_repository.dart';
import '../../home/domain/repositories/post_repository.dart';
import '../domain/repositories/friend_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  final PostRepository _postRepository;
  final FriendRepository _friendRepository;
  
  ProfileBloc({
    required ProfileRepository repository,
    required PostRepository postRepository,
    required FriendRepository friendRepository,
  })  : _repository = repository,
        _postRepository = postRepository,
        _friendRepository = friendRepository,
        super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onLoad);
    on<ProfileUpdateRequested>(_onUpdate);
    on<ProfileAvatarUploadRequested>(_onAvatarUpload);
    on<ProfileCoverUploadRequested>(_onCoverUpload);
    on<ProfileFriendRequestSent>(_onFriendRequestSent);
  }

  Future<void> _onLoad(ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      if (event.userId == null) {
        final user = await _repository.getMyProfile();
        final posts = await _postRepository.getUserPosts(user.id, page: 1, limit: 20);
        emit(ProfileLoaded(user: user, isOwnProfile: true, posts: posts));
      } else {
        final data = await _repository.getUserById(event.userId!);
        final user = UserModel.fromJson(data);
        final posts = await _postRepository.getUserPosts(user.id, page: 1, limit: 20);
        emit(ProfileLoaded(
          user: user,
          isOwnProfile: data['isOwnProfile'] == true,
          posts: posts,
          friendStatus: data['friendStatus'] != null 
             ? FriendStatus.values.firstWhere((e) => e.name == data['friendStatus'], orElse: () => FriendStatus.none)
             : FriendStatus.none,
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

  Future<void> _onFriendRequestSent(ProfileFriendRequestSent event, Emitter<ProfileState> emit) async {
    final current = state;
    if (current is! ProfileLoaded || current.isOwnProfile) return;
    
    // Optimistic update
    emit(current.copyWith(friendStatus: FriendStatus.pending));
    
    try {
      await _friendRepository.sendRequest(event.userId);
      print('Friend request sent successfully to ${event.userId}');
    } catch (e) {
      print('Friend request failed: $e');
      // Revert on failure
      emit(current);
    }
  }
}
