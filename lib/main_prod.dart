import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';

import 'app/music_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'api_keys_prod.env');
  AppConfig.fromFlavor(Flavor.prod);

  await LocaleSettings.setLocale(AppLocale.en);
  dataDependencyInjection.initialize();
  coreDependencyInjection.initialize();
  await serviceLocator.allReady();

  runApp(TranslationProvider(child: const MusicApp()));
}
