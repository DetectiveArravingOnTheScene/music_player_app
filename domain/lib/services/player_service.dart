import 'dart:async';
import 'package:just_audio/just_audio.dart';
import '../domain.dart';
import 'auth_service.dart';

class PlayerService {
  //MediaItem requires Unique ID for every instance. This is primitive, but i don't know better.
  int idCounter = 1;

  final AudioPlayer _player = AudioPlayer();
  final AuthService _authService;

  Stream<PlayerState> get playbackStateStream => _player.playerStateStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  PlayerService(AuthService authService) : _authService = authService;

  Future<void> playTrack(
    TrackModel track,
    Map<StreamTypeEnum, String>
    streamUrls, // I pass all streams, sooner or later i will add NetworkService, and i will be able to choose stream accroding to connection speed.
  ) async {
    try {
      final AudioSource source = HlsAudioSource(
        headers: _authService.getAuthHeader,
        Uri.parse(streamUrls[StreamTypeEnum.hlsAac160]!),
        tag: MediaItem(
          id: '$idCounter',
          title: track.title,
          artUri: Uri.tryParse(track.artworkUrl ?? ''),
          artist: track.artist.username,
          duration: Duration(milliseconds: track.duration),
          displayTitle: track.title,
          displaySubtitle: track.artist.username,
        ),
      );
      idCounter++;

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
