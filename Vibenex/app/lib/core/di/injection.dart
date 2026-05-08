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
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(repository: getIt<ProfileRepository>()),
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
}
