part of 'community_bloc.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();
  @override
  List<Object?> get props => [];
}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityLoaded extends CommunityState {
  final List<CommunityModel> communities;
  final bool hasReachedMax;
  final int currentPage;

  const CommunityLoaded({
    required this.communities,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [communities, hasReachedMax, currentPage];

  CommunityLoaded copyWith({
    List<CommunityModel>? communities,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return CommunityLoaded(
      communities: communities ?? this.communities,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class CommunityError extends CommunityState {
  final String message;
  const CommunityError(this.message);
  @override
  List<Object?> get props => [message];
}
