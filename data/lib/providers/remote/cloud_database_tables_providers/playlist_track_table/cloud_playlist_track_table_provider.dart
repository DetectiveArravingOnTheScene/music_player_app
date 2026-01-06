import '../../../../entities/supabase/cloud_playlist_track_metadata_entity.dart';

abstract class CloudPlaylistTracksTableProvider {
  Future<List<CloudPlaylistTrackMetadataEntity>> getByPlaylistId(
    String playlistId,
  );

  Future<CloudPlaylistTrackMetadataEntity> addTrack(
    CloudPlaylistTrackMetadataEntity entity,
  );

  Future<void> updateTrack(CloudPlaylistTrackMetadataEntity entity);

  Future<void> removeTrack(String playlistId, String urn);
}
