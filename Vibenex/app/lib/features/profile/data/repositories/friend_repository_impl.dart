import 'package:injectable/injectable.dart';
import '../../domain/repositories/friend_repository.dart';
import '../datasources/friend_api_service.dart';

@Injectable(as: FriendRepository)
class FriendRepositoryImpl implements FriendRepository {
  final FriendApiService _apiService;

  FriendRepositoryImpl(this._apiService);

  @override
  Future<void> sendRequest(String receiverId) async {
    await _apiService.sendRequest(receiverId);
  }

  @override
  Future<void> acceptRequest(String requestId) async {
    await _apiService.acceptRequest(requestId);
  }

  @override
  Future<void> rejectRequest(String requestId) async {
    await _apiService.rejectRequest(requestId);
  }

  @override
  Future<void> removeFriend(String friendId) async {
    await _apiService.removeFriend(friendId);
  }

  @override
  Future<List<dynamic>> getFriends() async {
    return await _apiService.getFriends() as List;
  }

  @override
  Future<List<dynamic>> getPendingRequests() async {
    return await _apiService.getPendingRequests() as List;
  }
}
