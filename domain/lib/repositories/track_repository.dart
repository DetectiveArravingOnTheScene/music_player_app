import '../domain.dart';

abstract class TrackRepository {
  Stream<TrackModel> get trackUpdates;

  Future<CollectionModel<TrackModel>> searchTracks(SearchTracksPayload request);

  Future<TrackModel> getTrack(String trackUrl);

  Future<Map<StreamTypeEnum, String>> getTrackStream(String streamUrl);

  Future<CollectionModel<TrackModel>> getRelatedTracks(String id);

  Future<CollectionModel<TrackModel>> getTrendingTracks();

  Future<void> likeTrack(TrackModel model);
  Future<void> removeLikeTrack(TrackModel model);

  void dispose();
  Future<CollectionModel<TrackModel>> getNextPage(String nextUrl);
}
