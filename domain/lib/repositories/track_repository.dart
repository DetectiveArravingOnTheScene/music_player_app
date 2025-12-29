import '../domain.dart';

abstract class TrackRepository {
  Future<CollectionModel<TrackModel>> searchTracks(SearchTracksPayload request);

  Future<TrackModel> getTrack(String trackUrl);

  Future<Map<StreamTypeEnum, String>> getTrackStream(String streamUrl);

  Future<CollectionModel<TrackModel>> getRelatedTracks(String id);

  Future<CollectionModel<TrackModel>> getTrendingTracks();
}
