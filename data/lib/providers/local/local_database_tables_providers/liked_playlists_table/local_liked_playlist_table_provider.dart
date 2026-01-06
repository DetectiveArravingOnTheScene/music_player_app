import '../../../../entities/isar/local_liked_playlist_metadata_entity.dart';

abstract class LocalLikedPlaylistsTableProvider {
  Future<LocalLikedPlaylistMetadataEntity?> getByUrn(String urn);

  Future<List<LocalLikedPlaylistMetadataEntity>> getByUserId(String userId);

  Future<LocalLikedPlaylistMetadataEntity> create(
    LocalLikedPlaylistMetadataEntity entity,
  );

  Future<LocalLikedPlaylistMetadataEntity> update(
    LocalLikedPlaylistMetadataEntity entity,
  );

  Future<void> delete(String urn);
}
