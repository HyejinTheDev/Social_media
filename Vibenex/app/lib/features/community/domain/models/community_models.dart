import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_models.freezed.dart';
part 'community_models.g.dart';

@freezed
abstract class CommunityModel with _$CommunityModel {
  const factory CommunityModel({
    required String id,
    required String name,
    String? description,
    String? icon,
    String? banner,
    @Default(true) bool isPublic,
    @Default(0) int memberCount,
    String? createdAt,
    String? updatedAt,
  }) = _CommunityModel;

  factory CommunityModel.fromJson(Map<String, dynamic> json) => _$CommunityModelFromJson(json);
}

@freezed
abstract class ChannelModel with _$ChannelModel {
  const factory ChannelModel({
    required String id,
    required String communityId,
    required String name,
    String? description,
    @Default('TEXT') String type,
    @Default(0) int position,
    String? createdAt,
  }) = _ChannelModel;

  factory ChannelModel.fromJson(Map<String, dynamic> json) => _$ChannelModelFromJson(json);
}

@freezed
abstract class PaginatedCommunitiesResponse with _$PaginatedCommunitiesResponse {
  const factory PaginatedCommunitiesResponse({
    required List<CommunityModel> communities,
    required int total,
  }) = _PaginatedCommunitiesResponse;

  factory PaginatedCommunitiesResponse.fromJson(Map<String, dynamic> json) => _$PaginatedCommunitiesResponseFromJson(json);
}
