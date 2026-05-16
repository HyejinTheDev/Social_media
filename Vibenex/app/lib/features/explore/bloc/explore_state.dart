part of 'explore_bloc.dart';

enum ExploreStatus { initial, loading, loaded, error }

class ExploreState extends Equatable {
  final ExploreStatus status;
  final String query;
  final List<UserModel> users;
  final List<CommunityModel> communities;
  final int total;
  final String? errorMessage;

  const ExploreState({
    this.status = ExploreStatus.initial,
    this.query = '',
    this.users = const [],
    this.communities = const [],
    this.total = 0,
    this.errorMessage,
  });

  ExploreState copyWith({
    ExploreStatus? status,
    String? query,
    List<UserModel>? users,
    List<CommunityModel>? communities,
    int? total,
    String? errorMessage,
  }) {
    return ExploreState(
      status: status ?? this.status,
      query: query ?? this.query,
      users: users ?? this.users,
      communities: communities ?? this.communities,
      total: total ?? this.total,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, query, users, communities, total, errorMessage];
}
