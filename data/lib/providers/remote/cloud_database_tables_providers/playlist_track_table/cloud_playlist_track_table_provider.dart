import '../../../../entities/supabase/playlist_track_metadata_entity.dart';

abstract class CloudPlaylistTracksTableProvider {
  Future<List<PlaylistTrackMetadataEntity>> getByPlaylistId(String playlistId);

  Future<PlaylistTrackMetadataEntity> addTrack(
    PlaylistTrackMetadataEntity entity,
  );

  Future<void> updateTrack(PlaylistTrackMetadataEntity entity);

  Future<void> removeTrack(String playlistId, String urn);
}
