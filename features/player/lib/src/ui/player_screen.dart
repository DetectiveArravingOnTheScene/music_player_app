import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setAsset('assets/song.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (player.playing) {
              player.pause();
            } else {
              player.play();
            }
          },
          child: Text("Press to play"),
        ),
      ),
    );
  }
}
