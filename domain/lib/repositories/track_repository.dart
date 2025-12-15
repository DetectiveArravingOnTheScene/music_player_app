import '../domain.dart';

abstract class TrackRepository {
  Future<List<TrackModel>> searchTracks(SearchTracksPayload request);

  Future<TrackModel> getTrack(String trackUrl);

  Future<String> getTrackStream(String streamUrl);

  Future<List<TrackModel>> getRelatedTracks(String id);
}
