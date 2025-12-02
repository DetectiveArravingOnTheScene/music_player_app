import 'package:core/di/app_di.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:music_player_app/app/music_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocale(AppLocale.en);
  coreDependencyInjection.initialize();

  runApp(TranslationProvider(child: MusicApp()));
}
