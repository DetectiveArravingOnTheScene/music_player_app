import '../../../../entities/isar/local_playlist_track_metadata_entity.dart';

abstract class LocalPlaylistTracksTableProvider {
  Future<List<LocalPlaylistTrackMetadataEntity>> getByPlaylistId(
    String playlistId,
  );

  Future<LocalPlaylistTrackMetadataEntity> addTrack(
    LocalPlaylistTrackMetadataEntity entity,
  );

  Future<LocalPlaylistTrackMetadataEntity> updateTrack(
    LocalPlaylistTrackMetadataEntity entity,
  );

  Future<void> removeTrack(String playlistId, String urn);
}
