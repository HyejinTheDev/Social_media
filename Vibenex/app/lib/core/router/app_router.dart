import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../di/injection.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/bloc/profile_bloc.dart';
import '../../features/post/presentation/pages/feed_screen.dart';
import '../../features/post/presentation/pages/create_post_screen.dart';
import '../../features/post/presentation/pages/post_detail_screen.dart';
import '../../features/post/presentation/pages/full_screen_image_viewer.dart';
import '../../features/post/domain/models/post_models.dart';
import '../../features/post/bloc/feed/feed_bloc.dart';
import '../../features/post/bloc/post/post_bloc.dart';
import '../../features/story/presentation/pages/create_story_screen.dart';
import '../../features/story/presentation/pages/story_viewer_screen.dart';
import '../../features/story/domain/models/story_models.dart';
import '../../features/story/bloc/story_bloc.dart';
import '../../features/follow/bloc/follow_bloc.dart';
import '../../features/follow/presentation/pages/followers_page.dart';
import '../../features/search/bloc/search_bloc.dart';
import '../../features/search/presentation/pages/search_screen.dart';
import '../../features/chat/bloc/chat_bloc.dart';
import '../../features/chat/presentation/pages/conversation_list_screen.dart';
import '../../features/chat/presentation/pages/chat_screen.dart';
import '../../features/notification/bloc/notification_bloc.dart';
import '../../features/notification/presentation/pages/notifications_page.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  void setAuthenticated(bool value) {
    if (_isAuthenticated != value) {
      _isAuthenticated = value;
      notifyListeners();
    }
  }
}

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();
  static final authNotifier = AuthNotifier();

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isAuth = authNotifier.isAuthenticated;
      final loc = state.uri.path;
      final isAuthPage = loc == '/login' || loc == '/register' || loc == '/forgot-password';
      if (loc == '/splash' || loc == '/onboarding') return null;
      if (!isAuth) return isAuthPage ? null : '/login';
      if (isAuth && isAuthPage) return '/feed';
      if (loc == '/') return '/feed';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', parentNavigatorKey: rootNavigatorKey, builder: (_, __) => const SplashPage()),
      GoRoute(path: '/onboarding', parentNavigatorKey: rootNavigatorKey, builder: (_, __) => const OnboardingPage()),
      GoRoute(path: '/login', parentNavigatorKey: rootNavigatorKey, builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', parentNavigatorKey: rootNavigatorKey, builder: (_, __) => const RegisterPage()),
      GoRoute(path: '/forgot-password', parentNavigatorKey: rootNavigatorKey, builder: (_, __) => const ForgotPasswordPage()),
      // Edit profile (full screen, outside shell)
      GoRoute(
        path: '/edit-profile',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const EditProfilePage(),
      ),
      // User profile (view other user)
      GoRoute(
        path: '/user/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, state) => BlocProvider(
          create: (_) => getIt<ProfileBloc>(),
          child: ProfilePage(userId: state.pathParameters['id']),
        ),
      ),
      // Post feature routes
      GoRoute(
        path: '/post/create',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const CreatePostScreen(),
      ),
      GoRoute(
        path: '/post/detail',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, state) {
          final post = state.extra as PostModel;
          return PostDetailScreen(post: post);
        },
      ),
      GoRoute(
        path: '/image-viewer',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          return FullScreenImageViewer(
            imageUrls: extra['imageUrls'] as List<String>,
            initialIndex: extra['initialIndex'] as int? ?? 0,
          );
        },
      ),
      // Story routes
      GoRoute(
        path: '/story/create',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => BlocProvider(
          create: (_) => getIt<StoryBloc>(),
          child: const CreateStoryScreen(),
        ),
      ),
      GoRoute(
        path: '/story/viewer',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (_) => getIt<StoryBloc>(),
            child: StoryViewerScreen(
              groups: extra['groups'] as List<StoryGroup>,
              initialGroupIndex: extra['initialGroupIndex'] as int? ?? 0,
            ),
          );
        },
      ),
      // Follow page route
      GoRoute(
        path: '/followers/:userId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, state) {
          final userId = state.pathParameters['userId']!;
          final tab = int.tryParse(state.uri.queryParameters['tab'] ?? '0') ?? 0;
          return BlocProvider(
            create: (_) => getIt<FollowBloc>(),
            child: FollowersPage(userId: userId, initialTab: tab),
          );
        },
      ),
      // Chat screen route
      GoRoute(
        path: '/chat/:conversationId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, state) {
          final conversationId = state.pathParameters['conversationId']!;
          final otherUser = state.extra as Map<String, dynamic>?;
          return BlocProvider(
            create: (_) => getIt<ChatBloc>(),
            child: ChatScreen(conversationId: conversationId, otherUser: otherUser),
          );
        },
      ),
      // Notifications route
      GoRoute(
        path: '/notifications',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) {
          return BlocProvider(
            create: (_) => getIt<NotificationBloc>(),
            child: const NotificationsPage(),
          );
        },
      ),
      // Profile by user ID
      GoRoute(
        path: '/profile/:userId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, state) {
          final userId = state.pathParameters['userId']!;
          return BlocProvider(
            create: (_) => getIt<ProfileBloc>(),
            child: ProfilePage(userId: userId),
          );
        },
      ),
      // Shell with bottom nav
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (_, __, child) => _ShellWithNav(child: child),
        routes: [
          GoRoute(
            path: '/feed',
            pageBuilder: (_, __) => NoTransitionPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => getIt<FeedBloc>()),
                  BlocProvider(create: (_) => getIt<PostBloc>()),
                ],
                child: const FeedScreen(),
              ),
            ),
          ),
          GoRoute(
            path: '/search',
            pageBuilder: (_, __) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => getIt<SearchBloc>(),
                child: const SearchScreen(),
              ),
            ),
          ),
          GoRoute(
            path: '/chat',
            pageBuilder: (_, __) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => getIt<ChatBloc>(),
                child: const ConversationListScreen(),
              ),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (_, __) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => getIt<ProfileBloc>(),
                child: const ProfilePage(),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

class _ShellWithNav extends StatelessWidget {
  final Widget child;
  const _ShellWithNav({required this.child});

  int _idx(BuildContext ctx) {
    final loc = GoRouterState.of(ctx).uri.path;
    if (loc.startsWith('/feed')) return 0;
    if (loc.startsWith('/search')) return 1;
    if (loc.startsWith('/chat')) return 2;
    if (loc.startsWith('/profile')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx(context),
        onDestinationSelected: (i) {
          switch (i) {
            case 0: context.go('/feed');
            case 1: context.go('/search');
            case 2: context.go('/chat');
            case 3: context.go('/profile');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Feed'),
          NavigationDestination(icon: Icon(Icons.search), selectedIcon: Icon(Icons.search), label: 'Tìm kiếm'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Hồ sơ'),
        ],
      ),
    );
  }
}
