import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:player/player.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        AutoTabsScaffold(
          routes: const [
            NamedRoute(Routes.homeRoute),
            NamedRoute(Routes.searchRoute),
            NamedRoute(Routes.collectionRoute),
          ],
          bottomNavigationBuilder: (context, tabsRouter) {
            return BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.system_update_tv_rounded),
                  label: "Collection",
                ),
              ],
            );
          },
        ),
        Positioned.directional(
          textDirection: TextDirection.ltr,
          bottom: 100,
          start: 0,
          end: 0,
          child: Row(children: [Expanded(child: PlayerWidget())]),
        ),
      ],
    );
  }
}
