import '../domain.dart';

abstract class TrackRepository {
  Future<List<TrackModel>> searchTracks(String query);

  Future<TrackModel> getTrack(String trackUrl);

  Future<void> getTrackStream(String streamUrl);
}
