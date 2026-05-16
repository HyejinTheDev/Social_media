import 'package:equatable/equatable.dart';
import '../data/models/short_model.dart';

enum ShortStatus { initial, loading, loaded, error }

class ShortState extends Equatable {
  final ShortStatus status;
  final List<ShortModel> shorts;
  final int page;
  final bool hasMore;
  final String? errorMessage;

  const ShortState({
    this.status = ShortStatus.initial,
    this.shorts = const [],
    this.page = 1,
    this.hasMore = true,
    this.errorMessage,
  });

  ShortState copyWith({
    ShortStatus? status,
    List<ShortModel>? shorts,
    int? page,
    bool? hasMore,
    String? errorMessage,
  }) {
    return ShortState(
      status: status ?? this.status,
      shorts: shorts ?? this.shorts,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, shorts, page, hasMore, errorMessage];
}
