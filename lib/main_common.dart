import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'app/music_app.dart';

Future<void> mainCommon(Flavor flavor, String apiKeysPath) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: apiKeysPath);
  serviceLocator.registerSingleton<AppConfig>(AppConfig.fromFlavor(flavor));

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.music_player_app.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  await LocaleSettings.setLocale(AppLocale.en);
  dataDependencyInjection.initialize();
  coreDependencyInjection.initialize();
  await serviceLocator.allReady();

  runApp(TranslationProvider(child: const MusicApp()));
}
