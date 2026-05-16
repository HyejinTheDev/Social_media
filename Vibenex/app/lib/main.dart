import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vibenex/l10n/app_localizations.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';
import 'core/l10n/locale_provider.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/profile/bloc/profile_bloc.dart';
import 'features/notification/bloc/notification_bloc.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/chat/data/datasources/socket_service.dart';
import 'core/widgets/offline_banner.dart';

import 'package:timeago/timeago.dart' as timeago;

final themeNotifier = ThemeNotifier();
final localeProvider = LocaleProvider();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  await configureDependencies();
  runApp(const VibenexApp());
}

class VibenexApp extends StatelessWidget {
  const VibenexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider<ProfileBloc>(create: (_) => getIt<ProfileBloc>()),
        BlocProvider<NotificationBloc>(create: (_) => getIt<NotificationBloc>()..add(FetchUnreadCount())),
        BlocProvider<HomeBloc>(create: (_) => getIt<HomeBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            AppRouter.authNotifier.setAuthenticated(true);
            getIt<SocketService>().connect();
            context.read<NotificationBloc>().add(FetchUnreadCount());
          } else if (state is AuthUnauthenticated || state is AuthError) {
            AppRouter.authNotifier.setAuthenticated(false);
            getIt<SocketService>().disconnect();
          }
        },
        child: ListenableBuilder(
          listenable: Listenable.merge([themeNotifier, localeProvider]),
          builder: (context, _) => MaterialApp.router(
            title: 'Vibenex',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeNotifier.themeMode,
            locale: localeProvider.locale,
            builder: (context, child) => child != null ? OfflineBanner(child: child) : const SizedBox.shrink(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('vi'), Locale('en')],
            routerConfig: AppRouter.router,
          ),
        ),
      ),
    );
  }
}
