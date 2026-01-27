import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'app/music_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'api_keys_prod.env');
  AppConfig.fromFlavor(Flavor.prod);

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
