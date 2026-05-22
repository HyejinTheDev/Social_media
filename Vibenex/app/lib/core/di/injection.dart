import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';
import '../../features/auth/data/datasources/auth_api_service.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/profile/data/datasources/profile_api_service.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/bloc/profile_bloc.dart';
import '../../features/profile/data/datasources/friend_api_service.dart';
import '../../features/profile/data/repositories/friend_repository_impl.dart';
import '../../features/profile/domain/repositories/friend_repository.dart';

import '../../features/explore/bloc/explore_bloc.dart';
import '../../features/explore/domain/repositories/explore_repository.dart';
import '../../features/explore/data/repositories/explore_repository_impl.dart';
import '../../features/home/data/datasources/post_api_service.dart';
import '../../features/home/data/repositories/post_repository_impl.dart';
import '../../features/home/domain/repositories/post_repository.dart';
import '../../features/home/bloc/home_bloc.dart';
import '../../features/home/data/datasources/story_api_service.dart';
import '../../features/home/data/repositories/story_repository_impl.dart';
import '../../features/home/domain/repositories/story_repository.dart';

import '../../features/chat/data/datasources/chat_api_service.dart';
import '../../features/chat/data/datasources/socket_service.dart';
import '../../features/chat/bloc/chat_bloc.dart';
import '../../features/notification/data/datasources/notification_api_service.dart';
import '../../features/notification/data/repositories/notification_repository_impl.dart';
import '../../features/notification/domain/repositories/notification_repository.dart';
import '../../features/notification/bloc/notification_bloc.dart';
import '../../features/community/data/datasources/community_api_service.dart';
import '../../features/community/data/repositories/community_repository_impl.dart';
import '../../features/community/domain/repositories/community_repository.dart';
import '../../features/community/bloc/community_bloc.dart';
import '../../features/discussion/data/datasources/discussion_api_service.dart';
import '../../features/discussion/data/repositories/discussion_repository_impl.dart';
import '../../features/discussion/domain/repositories/discussion_repository.dart';
import '../../features/discussion/bloc/discussion_bloc.dart';
import '../../features/shorts/bloc/short_bloc.dart';
import '../../features/shorts/data/datasources/short_api_service.dart';
import '../../features/shorts/data/repositories/short_repository.dart';
import '../../features/admin/data/admin_api_service.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // ─── Core ───
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // ─── Auth ───
  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(api: getIt<AuthApiService>()),
  );
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: getIt<AuthRepository>()),
  );

  // ─── Profile ───
  getIt.registerLazySingleton<ProfileApiService>(
    () => ProfileApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      api: getIt<ProfileApiService>(),
      dio: getIt<DioClient>().dio,
    ),
  );
  getIt.registerLazySingleton<FriendApiService>(
    () => FriendApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<FriendRepository>(
    () => FriendRepositoryImpl(getIt<FriendApiService>()),
  );

  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      repository: getIt<ProfileRepository>(),
      postRepository: getIt<PostRepository>(),
      friendRepository: getIt<FriendRepository>(),
    ),
  );


  // ─── Explore ───
  getIt.registerLazySingleton<ExploreRepository>(
    () => ExploreRepositoryImpl(
      profileApi: getIt<ProfileApiService>(),
      communityApi: getIt<CommunityApiService>(),
    ),
  );
  getIt.registerFactory(() => ExploreBloc(
    repository: getIt<ExploreRepository>(),
  ));

  // ─── Home ───
  getIt.registerLazySingleton<PostApiService>(
    () => PostApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(getIt<PostApiService>()),
  );
  getIt.registerLazySingleton<StoryApiService>(
    () => StoryApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<StoryRepository>(
    () => StoryRepositoryImpl(getIt<StoryApiService>()),
  );
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      getIt<PostRepository>(),
      getIt<StoryRepository>(),
    ),
  );

  // ─── Chat ───
  getIt.registerLazySingleton<ChatApiService>(
    () => ChatApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<SocketService>(
    () => SocketService(),
  );
  getIt.registerFactory(() => ChatBloc(api: getIt(), socket: getIt()));

  // ─── Community ───
  getIt.registerLazySingleton<CommunityApiService>(
    () => CommunityApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<CommunityRepository>(
    () => CommunityRepositoryImpl(api: getIt<CommunityApiService>()),
  );
  getIt.registerFactory<CommunityBloc>(
    () => CommunityBloc(repository: getIt<CommunityRepository>()),
  );

  // ─── Discussion ───
  getIt.registerLazySingleton<DiscussionApiService>(
    () => DiscussionApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<DiscussionRepository>(
    () => DiscussionRepositoryImpl(api: getIt<DiscussionApiService>()),
  );
  getIt.registerFactory<DiscussionBloc>(
    () => DiscussionBloc(repository: getIt<DiscussionRepository>()),
  );

  // ─── Notification ───
  getIt.registerLazySingleton<NotificationApiService>(
    () => NotificationApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(getIt<NotificationApiService>()),
  );
  getIt.registerLazySingleton(() => NotificationBloc(repository: getIt(), socket: getIt()));
  // ─── Shorts ───
  getIt.registerLazySingleton<ShortApiService>(
    () => ShortApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<ShortRepository>(
    () => ShortRepositoryImpl(getIt<ShortApiService>()),
  );
  getIt.registerFactory(() => ShortBloc(repository: getIt()));

  // ─── Admin ───
  getIt.registerLazySingleton<AdminApiService>(
    () => AdminApiService(getIt<DioClient>().dio),
  );
}
