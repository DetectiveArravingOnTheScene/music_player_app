import 'package:core/config/app_config.dart';
import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'app/music_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'api_keys_dev.env');
  serviceLocator.registerSingleton<AppConfig>(AppConfig.fromFlavor(Flavor.dev));

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.music_player_app.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  await LocaleSettings.setLocale(AppLocale.en);
  dataDependencyInjection.initialize();
  coreDependencyInjection.initialize();
  await serviceLocator.allReady();

  await serviceLocator.get<AuthRepository>().signOut();

  runApp(TranslationProvider(child: const MusicApp()));
}
