part of 'follow_bloc.dart';

enum FollowListStatus { initial, loading, loaded, error }

class FollowState extends Equatable {
  final Map<String, bool> followStatusMap;
  final FollowListStatus listStatus;
  final List<UserModel> users;
  final int total;
  final int currentPage;
  final int totalPages;
  final String? errorMessage;

  const FollowState({
    this.followStatusMap = const {},
    this.listStatus = FollowListStatus.initial,
    this.users = const [],
    this.total = 0,
    this.currentPage = 1,
    this.totalPages = 1,
    this.errorMessage,
  });

  bool get hasMore => currentPage < totalPages;

  FollowState copyWith({
    Map<String, bool>? followStatusMap,
    FollowListStatus? listStatus,
    List<UserModel>? users,
    int? total,
    int? currentPage,
    int? totalPages,
    String? errorMessage,
  }) {
    return FollowState(
      followStatusMap: followStatusMap ?? this.followStatusMap,
      listStatus: listStatus ?? this.listStatus,
      users: users ?? this.users,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [followStatusMap, listStatus, users, total, currentPage, totalPages, errorMessage];
}
