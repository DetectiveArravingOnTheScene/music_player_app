import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:music_player_app/app/music_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocale(AppLocale.en);
  coreDependencyInjection.initialize();
  dataDependencyInjection.initialize();

  runApp(TranslationProvider(child: MusicApp()));
}
