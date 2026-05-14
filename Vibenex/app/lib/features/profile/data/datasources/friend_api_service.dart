import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'friend_api_service.g.dart';

@RestApi()
abstract class FriendApiService {
  factory FriendApiService(Dio dio, {String baseUrl}) = _FriendApiService;

  @POST('/friends/request/{userId}')
  Future<dynamic> sendRequest(@Path('userId') String receiverId);

  @POST('/friends/accept/{requestId}')
  Future<dynamic> acceptRequest(@Path('requestId') String requestId);

  @POST('/friends/reject/{requestId}')
  Future<dynamic> rejectRequest(@Path('requestId') String requestId);

  @DELETE('/friends/{userId}')
  Future<dynamic> removeFriend(@Path('userId') String friendId);

  @GET('/friends')
  Future<dynamic> getFriends();

  @GET('/friends/requests')
  Future<dynamic> getPendingRequests();
}
