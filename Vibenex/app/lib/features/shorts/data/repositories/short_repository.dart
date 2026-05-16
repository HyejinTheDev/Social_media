import '../datasources/short_api_service.dart';
import '../models/short_model.dart';
import '../../../../core/utils/error_mapper.dart';

abstract class ShortRepository {
  Future<List<ShortModel>> getFeed(int page, String currentUserId);
  Future<bool> toggleLike(String shortId);
}

class ShortRepositoryImpl implements ShortRepository {
  final ShortApiService _api;

  ShortRepositoryImpl(this._api);

  @override
  Future<List<ShortModel>> getFeed(int page, String currentUserId) async {
    try {
      final data = await _api.getFeed(page);
      final list = data['data'] as List<dynamic>;
      return list.map((json) => ShortModel.fromJson(json, currentUserId)).toList();
    } catch (e) {
      throw Exception(ErrorMapper.map(e));
    }
  }

  @override
  Future<bool> toggleLike(String shortId) async {
    try {
      final data = await _api.toggleLike(shortId);
      return data['liked'] as bool;
    } catch (e) {
      throw Exception(ErrorMapper.map(e));
    }
  }
}
