import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:music_player_app/app/music_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'api_keys.env');

  LocaleSettings.setLocale(AppLocale.en);
  coreDependencyInjection.initialize();
  dataDependencyInjection.initialize();
  await serviceLocator.allReady();

  runApp(TranslationProvider(child: MusicApp()));
}
