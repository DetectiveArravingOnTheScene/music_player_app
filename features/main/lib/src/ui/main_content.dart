import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:player/player.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 28),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: <Widget>[
            AutoTabsScaffold(
              routes: const <PageRouteInfo<Object?>>[
                HomeRoute(),
                SearchRoute(),
                UserCollectionRoute(),
              ],
              bottomNavigationBuilder:
                  (BuildContext context, TabsRouter tabsRouter) {
                    return BottomNavigationBar(
                      currentIndex: tabsRouter.activeIndex,
                      onTap: tabsRouter.setActiveIndex,
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.home),
                          label: t.pages.home,
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.search),
                          label: t.pages.search,
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.system_update_tv_rounded),
                          label: t.pages.collection,
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
              child: const Row(
                children: <Widget>[Expanded(child: PlayerWidget())],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
