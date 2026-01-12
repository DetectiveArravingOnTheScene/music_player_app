import 'dart:async';
import 'package:just_audio/just_audio.dart';
import '../domain.dart';

class PlayerService {
  final AudioPlayer _player = AudioPlayer();

  Stream<PlayerState> get playbackStateStream => _player.playerStateStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  Future<void> playTrack(TrackModel track, String trackStreamUrl) async {
    try {
      final AudioSource source = AudioSource.uri(
        Uri.parse(trackStreamUrl),
        tag:
            track, //Later this will be updated to support defaul android audio widgets
      );

      await _player.setAudioSource(source);
      await _player.play();
    } catch (e) {
      throw Exception('Failed to load track: $e');
    }
  }

  Future<void> pause() => _player.pause();
  Future<void> resume() => _player.play();
  Future<void> seek(Duration position) => _player.seek(position);
  Future<void> stop() => _player.stop();
  Future<void> setVolume(double volume) => _player.setVolume(volume);

  void dispose() => _player.dispose();
}
