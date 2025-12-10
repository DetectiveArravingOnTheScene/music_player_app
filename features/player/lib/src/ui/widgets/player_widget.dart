import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: ElevatedButton(
        onPressed: () => context.router.push(const PlayerRoute()),
        child: const Text('PRESS ME'),
      ),
    );
  }
}
