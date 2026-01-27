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

class PlayerLikeTrack extends PlayerEvent {
  final TrackModel track;
  final bool liked;
  PlayerLikeTrack({required this.track, required this.liked});
}

class TrackUpdatedEvent extends PlayerEvent {
  TrackModel updatedTrack;
  TrackUpdatedEvent(this.updatedTrack);
}

// Internal event triggered when the audio player notifies us of state changes
class _PlayerPlaybackStateChanged extends PlayerEvent {
  final PlayerState state;
  _PlayerPlaybackStateChanged(this.state);
}
