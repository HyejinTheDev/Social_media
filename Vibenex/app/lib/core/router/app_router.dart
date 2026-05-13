import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../di/injection.dart';
import '../theme/app_colors.dart';
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
import '../../features/community/presentation/pages/community_detail_page.dart';
import '../../features/discussion/presentation/pages/channel_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/bloc/profile_bloc.dart';
import '../../features/explore/bloc/explore_bloc.dart';
import '../../features/explore/presentation/pages/explore_page.dart';
import '../../features/chat/bloc/chat_bloc.dart';
import '../../features/chat/presentation/pages/conversation_list_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
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
              child: ChatPage(conversationId: conversationId, otherUser: otherUser),
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
            path: '/explore',
            pageBuilder: (_, __) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => getIt<ExploreBloc>(),
                child: const ExplorePage(),
              ),
            ),
          ),
          GoRoute(
            path: '/chat',
            pageBuilder: (_, __) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => getIt<ChatBloc>(),
                child: const ConversationListPage(),
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
    if (loc.startsWith('/explore')) return 1;
    if (loc.startsWith('/chat')) return 2;
    if (loc.startsWith('/profile')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _idx(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surfaceMidnight,
          border: Border(
            top: BorderSide(color: AppColors.borderTwilight, width: 0.5),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Home',
                  isSelected: currentIndex == 0,
                  onTap: () => context.go('/communities'),
                ),
                _NavItem(
                  icon: Icons.explore_outlined,
                  activeIcon: Icons.explore,
                  label: 'Spaces',
                  isSelected: currentIndex == 1,
                  onTap: () => context.go('/explore'),
                ),
                _NavItem(
                  icon: Icons.chat_bubble_outline,
                  activeIcon: Icons.chat_bubble,
                  label: 'Messages',
                  isSelected: currentIndex == 2,
                  onTap: () => context.go('/chat'),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Profile',
                  isSelected: currentIndex == 3,
                  onTap: () => context.go('/profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brandViolet.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.brandViolet : AppColors.textFog,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.brandViolet : AppColors.textFog,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
