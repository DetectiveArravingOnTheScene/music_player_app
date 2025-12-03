import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [NamedRoute('PlayerRoute'), NamedRoute('MamaRoute')],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: "HI"),
            BottomNavigationBarItem(
              icon: Icon(Icons.h_mobiledata),
              label: "DIE",
            ),
          ],
        );
      },
    );
  }
}
