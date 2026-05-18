import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../di/injection.dart';
import '../../features/chat/data/datasources/chat_api_service.dart';
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
import '../../features/community/presentation/pages/live_chat_channel_page.dart';
import '../../features/community/presentation/pages/voice_room_page.dart';
import '../../features/discussion/presentation/pages/channel_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/bloc/profile_bloc.dart';
import '../../features/explore/bloc/explore_bloc.dart';
import '../../features/explore/presentation/pages/explore_page.dart';
import '../../features/chat/bloc/chat_bloc.dart';
import '../../features/chat/presentation/pages/conversation_list_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/create_post_page.dart';
import '../../features/home/presentation/pages/create_story_page.dart';
import '../../features/shorts/presentation/pages/shorts_page.dart';
import '../../features/shorts/presentation/pages/create_short_page.dart';
import '../../features/shorts/bloc/short_bloc.dart';
import '../../features/notification/bloc/notification_bloc.dart';
import '../../features/notification/presentation/pages/notifications_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/change_password_page.dart';
import '../../features/profile/presentation/pages/friends_list_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';
import '../../features/admin/presentation/pages/admin_users_page.dart';
import '../../features/admin/presentation/pages/admin_posts_page.dart';
import '../../features/admin/presentation/pages/admin_shorts_page.dart';
import '../../features/admin/presentation/pages/admin_communities_page.dart';

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
      if (isAuth && isAuthPage) return '/home';
      if (loc == '/') return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', parentNavigatorKey: rootNavigatorKey, builder: (_, __) => const SplashPage()),
      GoRoute(path: '/onboarding', parentNavigatorKey: rootNavigatorKey, builder: (_, __) => const OnboardingPage()),
      GoRoute(path: '/login', parentNavigatorKey: rootNavigatorKey, builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', parentNavigatorKey: rootNavigatorKey, builder: (_, __) => const RegisterPage()),
      GoRoute(path: '/forgot-password', parentNavigatorKey: rootNavigatorKey, builder: (_, __) => const ForgotPasswordPage()),

      // ─── Admin Routes ───
      GoRoute(path: '/admin', parentNavigatorKey: rootNavigatorKey, pageBuilder: (ctx, state) => _slideTransition(ctx, state, const AdminDashboardPage())),
      GoRoute(path: '/admin/users', parentNavigatorKey: rootNavigatorKey, pageBuilder: (ctx, state) => _slideTransition(ctx, state, const AdminUsersPage())),
      GoRoute(path: '/admin/posts', parentNavigatorKey: rootNavigatorKey, pageBuilder: (ctx, state) => _slideTransition(ctx, state, const AdminPostsPage())),
      GoRoute(path: '/admin/shorts', parentNavigatorKey: rootNavigatorKey, pageBuilder: (ctx, state) => _slideTransition(ctx, state, const AdminShortsPage())),
      GoRoute(path: '/admin/communities', parentNavigatorKey: rootNavigatorKey, pageBuilder: (ctx, state) => _slideTransition(ctx, state, const AdminCommunitiesPage())),

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
      // Conversation list route
      GoRoute(
        path: '/chat',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          return _slideTransition(
            context,
            state,
            BlocProvider(
              create: (_) => getIt<ChatBloc>(),
              child: const ConversationListPage(),
            ),
          );
        },
      ),
      // Shorts routes
      GoRoute(
        path: '/create-short',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _slideTransition(context, state, const CreateShortPage()),
      ),
      // Explore routes
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
      // Friends list
      GoRoute(
        path: '/friends',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _slideTransition(context, state, const FriendsListPage()),
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
      // Live Chat Channel route
      GoRoute(
        path: '/communities/:communityId/live-chat/:channelId',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final channelId = state.pathParameters['channelId']!;
          final communityId = state.pathParameters['communityId']!;
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return _slideTransition(
            context,
            state,
            LiveChatChannelPage(
              communityId: communityId,
              channelId: channelId,
              channelName: extra['channelName'] ?? 'live',
              communityName: extra['communityName'] ?? '',
            ),
          );
        },
      ),
      // Voice Room route
      GoRoute(
        path: '/communities/:communityId/voice-room/:channelId',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final channelId = state.pathParameters['channelId']!;
          final communityId = state.pathParameters['communityId']!;
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return _slideTransition(
            context,
            state,
            VoiceRoomPage(
              communityId: communityId,
              channelId: channelId,
              channelName: extra['channelName'] ?? 'voice',
              communityName: extra['communityName'] ?? '',
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
            path: '/home',
            pageBuilder: (_, __) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),
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
            path: '/chat-list',
            pageBuilder: (_, __) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => getIt<ChatBloc>(),
                child: const ConversationListPage(),
              ),
            ),
          ),
          GoRoute(
            path: '/shorts',
            pageBuilder: (_, __) => NoTransitionPage(
              child: BlocProvider.value(
                value: getIt<ShortBloc>(),
                child: const ShortsPage(),
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
      // ─── Chat routes ───
      GoRoute(
        path: '/chat/new/:userId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          final otherUser = state.extra as Map<String, dynamic>?;
          return FutureBuilder(
            future: getIt<ChatApiService>().getOrCreateConversation(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Scaffold(
                  backgroundColor: AppColors.background,
                  body: Center(child: CircularProgressIndicator(color: AppColors.brandViolet)),
                );
              }
              if (snapshot.hasError) {
                return const Scaffold(
                  backgroundColor: AppColors.background,
                  appBar: null,
                  body: Center(child: Text('Lỗi tạo cuộc trò chuyện', style: TextStyle(color: AppColors.textFog))),
                );
              }
              final conv = snapshot.data!;
              return BlocProvider(
                create: (_) => getIt<ChatBloc>(),
                child: ChatPage(conversationId: conv['id'], otherUser: otherUser),
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/chat/:conversationId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final conversationId = state.pathParameters['conversationId']!;
          final otherUser = state.extra as Map<String, dynamic>?;
          return BlocProvider(
            create: (_) => getIt<ChatBloc>(),
            child: ChatPage(conversationId: conversationId, otherUser: otherUser),
          );
        },
      ),
      GoRoute(
        path: '/create-post',
        builder: (context, state) => CreatePostPage(
          initialText: state.extra as String?,
        ),
      ),
      GoRoute(
        path: '/create-story',
        builder: (context, state) => const CreateStoryPage(),
      ),
      GoRoute(
        path: '/notifications',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          return BlocProvider.value(
            value: getIt<NotificationBloc>(),
            child: const NotificationsPage(),
          );
        },
      ),
    ],
  );
}

class _ShellWithNav extends StatelessWidget {
  final Widget child;
  const _ShellWithNav({required this.child});

  int _idx(BuildContext ctx) {
    final loc = GoRouterState.of(ctx).uri.path;
    if (loc.startsWith('/home')) return 0;
    if (loc.startsWith('/explore')) return 1;
    if (loc.startsWith('/communities')) return 2;
    if (loc.startsWith('/chat-list')) return 3;
    if (loc.startsWith('/shorts')) return 4;
    if (loc.startsWith('/profile')) return 5;
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
                  label: 'Trang chủ',
                  isSelected: currentIndex == 0,
                  onTap: () => context.go('/home'),
                ),
                _NavItem(
                  icon: Icons.search_outlined,
                  activeIcon: Icons.search,
                  label: 'Tìm kiếm',
                  isSelected: currentIndex == 1,
                  onTap: () => context.go('/explore'),
                ),
                _NavItem(
                  icon: Icons.people_outline,
                  activeIcon: Icons.people,
                  label: 'Phòng',
                  isSelected: currentIndex == 2,
                  onTap: () => context.go('/communities'),
                ),
                _NavItem(
                  icon: Icons.mail_outline,
                  activeIcon: Icons.mail,
                  label: 'Tin nhắn',
                  isSelected: currentIndex == 3,
                  onTap: () => context.go('/chat-list'),
                ),
                _NavItem(
                  icon: Icons.play_circle_outline,
                  activeIcon: Icons.play_circle,
                  label: 'Shorts',
                  isSelected: currentIndex == 4,
                  onTap: () => context.go('/shorts'),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Hồ sơ',
                  isSelected: currentIndex == 5,
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brandViolet.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.brandViolet : AppColors.textFog,
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.brandViolet : AppColors.textFog,
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
