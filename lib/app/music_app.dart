import 'package:core/core.dart';
<<<<<<< HEAD
import 'package:core_ui/theme/app_theme.dart';
=======
import 'package:core/di/app_di.dart';
>>>>>>> parent of 222634d ([P2.1] Add SupabaseAuthProvider and AuthRepository)
import 'package:flutter/material.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routerConfig: serviceLocator.get<AppRouter>().config(),
    );
  }
}
