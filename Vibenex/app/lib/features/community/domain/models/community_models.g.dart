// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommunityModel _$CommunityModelFromJson(Map<String, dynamic> json) =>
    _CommunityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      banner: json['banner'] as String?,
      isPublic: json['isPublic'] as bool? ?? true,
      isVoiceRoom: json['isVoiceRoom'] as bool? ?? false,
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CommunityModelToJson(_CommunityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'banner': instance.banner,
      'isPublic': instance.isPublic,
      'isVoiceRoom': instance.isVoiceRoom,
      'memberCount': instance.memberCount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) =>
    _ChannelModel(
      id: json['id'] as String,
      communityId: json['communityId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String? ?? 'TEXT',
      position: (json['position'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ChannelModelToJson(_ChannelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'communityId': instance.communityId,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'position': instance.position,
      'createdAt': instance.createdAt,
    };

_PaginatedCommunitiesResponse _$PaginatedCommunitiesResponseFromJson(
        Map<String, dynamic> json) =>
    _PaginatedCommunitiesResponse(
      communities: (json['communities'] as List<dynamic>)
          .map((e) => CommunityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PaginatedCommunitiesResponseToJson(
        _PaginatedCommunitiesResponse instance) =>
    <String, dynamic>{
      'communities': instance.communities,
      'total': instance.total,
    };
