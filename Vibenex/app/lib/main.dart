import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vibenex/l10n/app_localizations.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';
import 'core/l10n/locale_provider.dart';

final themeNotifier = ThemeNotifier();
final localeProvider = LocaleProvider();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
  await configureDependencies();
  runApp(const VibenexApp());
}

class VibenexApp extends StatelessWidget {
  const VibenexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([themeNotifier, localeProvider]),
      builder: (context, _) => MaterialApp.router(
        title: 'Vibenex',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeNotifier.themeMode,
        locale: localeProvider.locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('vi'), Locale('en')],
        routerConfig: AppRouter.router,
      ),
    );
  }
}
