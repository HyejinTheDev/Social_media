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
import '../../features/community/bloc/community_bloc.dart';
import '../../features/community/presentation/pages/communities_page.dart';
import '../../features/community/presentation/pages/create_community_page.dart';
import '../../features/discussion/bloc/discussion_bloc.dart';
import '../../features/discussion/presentation/pages/community_detail_page.dart';
import '../../features/discussion/presentation/pages/channel_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/bloc/profile_bloc.dart';
import '../../features/search/bloc/search_bloc.dart';
import '../../features/search/presentation/pages/search_screen.dart';
import '../../features/chat/bloc/chat_bloc.dart';
import '../../features/chat/presentation/pages/conversation_list_screen.dart';
import '../../features/chat/presentation/pages/chat_screen.dart';
import '../../features/notification/bloc/notification_bloc.dart';
import '../../features/notification/presentation/pages/notifications_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/change_password_page.dart';

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

Page<dynamic> _slideTransition(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic))),
        child: child,
      );
    },
  );
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
      if (isAuth && isAuthPage) return '/communities';
      if (loc == '/') return '/communities';
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

      // Chat screen route
      GoRoute(
        path: '/chat/:conversationId',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final conversationId = state.pathParameters['conversationId']!;
          final otherUser = state.extra as Map<String, dynamic>?;
          return _slideTransition(
            context,
            state,
            BlocProvider(
              create: (_) => getIt<ChatBloc>(),
              child: ChatScreen(conversationId: conversationId, otherUser: otherUser),
            ),
          );
        },
      ),
      // Notifications route
      GoRoute(
        path: '/notifications',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          return _slideTransition(
            context,
            state,
            BlocProvider(
              create: (_) => getIt<NotificationBloc>(),
              child: const NotificationsPage(),
            ),
          );
        },
      ),
      // Settings routes
      GoRoute(
        path: '/settings',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _slideTransition(context, state, const SettingsPage()),
      ),
      GoRoute(
        path: '/change-password',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const ChangePasswordPage(),
      ),
      // Create community page
      GoRoute(
        path: '/create-community',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          return _slideTransition(
            context,
            state,
            BlocProvider.value(
              value: getIt<CommunityBloc>(),
              child: const CreateCommunityPage(),
            ),
          );
        },
      ),
      // Community detail page
      GoRoute(
        path: '/communities/:communityId',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final communityId = state.pathParameters['communityId']!;
          return _slideTransition(context, state, CommunityDetailPage(communityId: communityId));
        },
      ),
      // Channel page (discussions inside a channel)
      GoRoute(
        path: '/communities/:communityId/channels/:channelId',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final channelId = state.pathParameters['channelId']!;
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return _slideTransition(
            context,
            state,
            BlocProvider(
              create: (_) => getIt<DiscussionBloc>(),
              child: ChannelPage(
                channelId: channelId,
                channelName: extra['channelName'] ?? 'general',
                communityName: extra['communityName'] ?? '',
              ),
            ),
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
            path: '/communities',
            pageBuilder: (_, __) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => getIt<CommunityBloc>(),
                child: const CommunitiesPage(),
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
    if (loc.startsWith('/communities')) return 0;
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
            case 0: context.go('/communities');
            case 1: context.go('/search');
            case 2: context.go('/chat');
            case 3: context.go('/profile');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups), label: 'Communities'),
          NavigationDestination(icon: Icon(Icons.search), selectedIcon: Icon(Icons.search), label: 'Khám phá'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Hồ sơ'),
        ],
      ),
    );
  }
}
