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

import '../../features/post/data/datasources/post_api_service.dart';
import '../../features/post/data/repositories/post_repository_impl.dart';
import '../../features/post/domain/repositories/post_repository.dart';
import '../../features/post/domain/usecases/post_usecases.dart';
import '../../features/post/bloc/feed/feed_bloc.dart';
import '../../features/post/bloc/post/post_bloc.dart';
import '../../features/post/bloc/comment/comment_bloc.dart';

import '../../features/story/data/datasources/story_api_service.dart';
import '../../features/story/data/repositories/story_repository_impl.dart';
import '../../features/story/domain/models/story_repository.dart';
import '../../features/story/domain/usecases/story_usecases.dart';
import '../../features/story/bloc/story_bloc.dart';

import '../../features/follow/data/datasources/follow_api_service.dart';
import '../../features/follow/bloc/follow_bloc.dart';
import '../../features/search/bloc/search_bloc.dart';

import '../../features/chat/data/datasources/chat_api_service.dart';
import '../../features/chat/data/datasources/socket_service.dart';
import '../../features/chat/bloc/chat_bloc.dart';

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
  // Note: FollowApiService is registered below, but getIt resolves lazily at call time
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(repository: getIt<ProfileRepository>(), followApi: getIt<FollowApiService>()),
  );

  // ─── Post & Feed ───
  getIt.registerLazySingleton<PostApiService>(
    () => PostApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      api: getIt<PostApiService>(),
      dio: getIt<DioClient>().dio,
    ),
  );

  // UseCases
  getIt.registerLazySingleton(() => GetFeedUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUserPostsUseCase(getIt()));
  getIt.registerLazySingleton(() => CreatePostUseCase(getIt()));
  getIt.registerLazySingleton(() => DeletePostUseCase(getIt()));
  getIt.registerLazySingleton(() => ToggleLikeUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCommentsUseCase(getIt()));
  getIt.registerLazySingleton(() => AddCommentUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteCommentUseCase(getIt()));

  // Blocs
  getIt.registerFactory(() => FeedBloc(getFeed: getIt()));
  getIt.registerFactory(() => PostBloc(
    createPost: getIt(),
    deletePost: getIt(),
    toggleLike: getIt(),
  ));
  getIt.registerFactory(() => CommentBloc(
    getComments: getIt(),
    addComment: getIt(),
    deleteComment: getIt(),
  ));

  // ─── Story ───
  getIt.registerLazySingleton<StoryApiService>(
    () => StoryApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<StoryRepository>(
    () => StoryRepositoryImpl(
      api: getIt<StoryApiService>(),
      dio: getIt<DioClient>().dio,
    ),
  );

  // Story UseCases
  getIt.registerLazySingleton(() => GetActiveStoriesUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateStoryUseCase(getIt()));
  getIt.registerLazySingleton(() => ViewStoryUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteStoryUseCase(getIt()));
  getIt.registerLazySingleton(() => GetMyStoriesUseCase(getIt()));

  // Story BLoC
  getIt.registerFactory(() => StoryBloc(
    getActiveStories: getIt(),
    createStory: getIt(),
    viewStory: getIt(),
    deleteStory: getIt(),
  ));

  // ─── Follow & Search ───
  getIt.registerLazySingleton<FollowApiService>(
    () => FollowApiService(getIt<DioClient>().dio),
  );
  getIt.registerFactory(() => FollowBloc(api: getIt()));
  getIt.registerFactory(() => SearchBloc(api: getIt()));

  // ─── Chat ───
  getIt.registerLazySingleton<ChatApiService>(
    () => ChatApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<SocketService>(
    () => SocketService(),
  );
  getIt.registerFactory(() => ChatBloc(api: getIt(), socket: getIt()));
}
