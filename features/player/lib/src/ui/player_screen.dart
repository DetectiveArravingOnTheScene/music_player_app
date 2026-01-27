import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Press to play'),
        ),
      ),
    );
  }
}
