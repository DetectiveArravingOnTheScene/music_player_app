part of 'player_bloc.dart';

class PlayerEvent {}

class PlayerInit extends PlayerEvent {}

class PlayerSetPlaylist extends PlayerEvent {
  final List<TrackModel> playlist;
  final int initialIndex;
  PlayerSetPlaylist({required this.playlist, this.initialIndex = 0});
}

class PlayerPlay extends PlayerEvent {}

class PlayerPause extends PlayerEvent {}

class PlayerNext extends PlayerEvent {}

class PlayerPrevious extends PlayerEvent {}

class PlayerSeek extends PlayerEvent {
  final Duration position;
  PlayerSeek(this.position);
}

class PlayerToggleShuffle extends PlayerEvent {}

class PlayerToggleLoop extends PlayerEvent {}

// Internal event triggered when the audio player notifies us of state changes
class _PlayerPlaybackStateChanged extends PlayerEvent {
  final ja.PlayerState state;
  _PlayerPlaybackStateChanged(this.state);
}
