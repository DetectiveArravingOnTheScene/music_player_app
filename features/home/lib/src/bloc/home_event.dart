import 'package:domain/models/music_models/track_model.dart';

class HomeEvent {
  const HomeEvent();
}

class HomePageOpenedEvent extends HomeEvent {
  const HomePageOpenedEvent();
}

class TrackUpdatedEvent extends HomeEvent {
  TrackModel updatedTrack;
  TrackUpdatedEvent(this.updatedTrack);
}

class HomeLikeTrack extends HomeEvent {
  final TrackModel track;
  final bool liked;
  HomeLikeTrack({required this.track, required this.liked});
}
