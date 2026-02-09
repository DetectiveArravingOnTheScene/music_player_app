import 'dart:async';
import 'package:domain/domain.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:uuid/uuid.dart';

part 'player_state.dart';

class PlayerService {
  final ja.AudioPlayer _player = ja.AudioPlayer();
  final AuthService _authService;
  final Uuid _uuid = const Uuid();

  Stream<PlayerState> get playbackStateStream {
    return _player.playerStateStream.map(
      (ja.PlayerState jaState) => PlayerState(
        isPlaying: jaState.playing,
        processingState: _mapProcessingState(jaState.processingState),
      ),
    );
  }

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  PlayerService(AuthService authService) : _authService = authService;

  Future<void> playTrack(
    TrackModel track,
    Map<StreamTypeEnum, String>
    streamUrls, //TODO: Add logic for choosing streams based on current network connection.
  ) async {
    try {
      final ja.AudioSource source = ja.AudioSource.uri(
        headers: _authService.getAuthHeader,
        Uri.parse(streamUrls[StreamTypeEnum.httpMp3128]!),
        tag: MediaItem(
          id: _uuid.v4(),
          title: track.title,
          artUri: Uri.tryParse(track.artworkUrl ?? ''),
          artist: track.artist.username,
          duration: Duration(milliseconds: track.duration),
          displayTitle: track.title,
          displaySubtitle: track.artist.username,
        ),
      );

      await _player.setAudioSource(source);
      unawaited(_player.play());
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
