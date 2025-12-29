import '../domain.dart';
import '../models/music_models/collection_model.dart';
import '../models/music_models/stream_type.dart';
import '../payloads/search_tracks_payload.dart';

abstract class TrackRepository {
  Future<CollectionModel<TrackModel>> searchTracks(SearchTracksPayload request);

  Future<TrackModel> getTrack(String trackUrl);

  Future<Map<StreamType, String>> getTrackStream(String streamUrl);

  Future<CollectionModel<TrackModel>> getRelatedTracks(String id);
}
