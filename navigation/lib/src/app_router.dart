import 'package:home/home.dart';
import 'package:main/main.dart';
import 'package:navigation/navigation.dart';
import 'package:player/player.dart';
import 'package:search/search.dart';
import 'package:user_collection/user_collection.dart';

class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    NamedRouteDef(
      name: Routes.mainRoute,
      initial: true,
      builder: (context, state) => MainScreen(),
      children: [
        NamedRouteDef(
          name: Routes.homeRoute,
          builder: (context, state) => HomeScreen(),
        ),
        NamedRouteDef(
          name: Routes.searchRoute,
          builder: (context, state) => SearchScreen(),
        ),
        NamedRouteDef(
          name: Routes.collectionRoute,
          builder: (context, state) => UserCollectionScreen(),
        ),
      ],
    ),
    NamedRouteDef(
      name: Routes.playerRoute,
      builder: (context, state) => PlayerScreen(),
    ),
  ];
}
