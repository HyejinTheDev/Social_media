// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpaceModel _$SpaceModelFromJson(Map<String, dynamic> json) => _SpaceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      avatar: json['avatar'] as String?,
      coverPhoto: json['coverPhoto'] as String?,
      isPrivate: json['isPrivate'] as bool? ?? false,
      ownerId: json['ownerId'] as String,
      membersCount: (json['membersCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$SpaceModelToJson(_SpaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'avatar': instance.avatar,
      'coverPhoto': instance.coverPhoto,
      'isPrivate': instance.isPrivate,
      'ownerId': instance.ownerId,
      'membersCount': instance.membersCount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) =>
    _ChannelModel(
      id: json['id'] as String,
      spaceId: json['spaceId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String? ?? 'TEXT',
      isPrivate: json['isPrivate'] as bool? ?? false,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ChannelModelToJson(_ChannelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spaceId': instance.spaceId,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'isPrivate': instance.isPrivate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_PaginatedSpacesResponse _$PaginatedSpacesResponseFromJson(
        Map<String, dynamic> json) =>
    _PaginatedSpacesResponse(
      spaces: (json['spaces'] as List<dynamic>)
          .map((e) => SpaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PaginatedSpacesResponseToJson(
        _PaginatedSpacesResponse instance) =>
    <String, dynamic>{
      'spaces': instance.spaces,
      'total': instance.total,
    };
