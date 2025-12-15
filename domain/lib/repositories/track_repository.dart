import '../domain.dart';

abstract class TrackRepository {
  Future<List<TrackModel>> searchTracks(
    String query, {
    int? limit,
    (int, int)? bpm,
    (int, int)? duration,
    List<String>? genres,
  });

  Future<TrackModel> getTrack(String trackUrl);

  Future<String> getTrackStream(String streamUrl);

  Future<List<TrackModel>> getRelatedTracks(String id);
}
