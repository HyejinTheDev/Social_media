abstract class FriendRepository {
  Future<void> sendRequest(String receiverId);
  Future<void> acceptRequest(String requestId);
  Future<void> rejectRequest(String requestId);
  Future<void> removeFriend(String friendId);
  Future<List<dynamic>> getFriends();
  Future<List<dynamic>> getPendingRequests();
}
