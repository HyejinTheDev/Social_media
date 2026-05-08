import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';

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
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (_, __, child) => _ShellWithNav(child: child),
        routes: [
          GoRoute(path: '/feed', pageBuilder: (_, __) => const NoTransitionPage(child: Scaffold(body: Center(child: Text('Feed'))))),
          GoRoute(path: '/search', pageBuilder: (_, __) => const NoTransitionPage(child: Scaffold(body: Center(child: Text('Search'))))),
          GoRoute(path: '/chat', pageBuilder: (_, __) => const NoTransitionPage(child: Scaffold(body: Center(child: Text('Chat'))))),
          GoRoute(path: '/profile', pageBuilder: (_, __) => const NoTransitionPage(child: Scaffold(body: Center(child: Text('Profile'))))),
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
