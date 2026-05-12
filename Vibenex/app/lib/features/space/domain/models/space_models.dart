import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_models.freezed.dart';
part 'space_models.g.dart';

@freezed
abstract class SpaceModel with _$SpaceModel {
  const factory SpaceModel({
    required String id,
    required String name,
    String? description,
    String? avatar,
    String? coverPhoto,
    @Default(false) bool isPrivate,
    required String ownerId,
    @Default(0) int membersCount,
    String? createdAt,
    String? updatedAt,
  }) = _SpaceModel;

  factory SpaceModel.fromJson(Map<String, dynamic> json) => _$SpaceModelFromJson(json);
}

@freezed
abstract class ChannelModel with _$ChannelModel {
  const factory ChannelModel({
    required String id,
    required String spaceId,
    required String name,
    String? description,
    @Default('TEXT') String type,
    @Default(false) bool isPrivate,
    String? createdAt,
    String? updatedAt,
  }) = _ChannelModel;

  factory ChannelModel.fromJson(Map<String, dynamic> json) => _$ChannelModelFromJson(json);
}

@freezed
abstract class PaginatedSpacesResponse with _$PaginatedSpacesResponse {
  const factory PaginatedSpacesResponse({
    required List<SpaceModel> spaces,
    required int total,
  }) = _PaginatedSpacesResponse;

  factory PaginatedSpacesResponse.fromJson(Map<String, dynamic> json) => _$PaginatedSpacesResponseFromJson(json);
}
