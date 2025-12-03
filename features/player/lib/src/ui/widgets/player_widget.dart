import 'package:core/core.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: ElevatedButton(
        onPressed: () => context.router.push(NamedRoute(Routes.playerRoute)),
        child: Text("PRESS ME"),
      ),
    );
  }
}
