import '../../../../entities/isar/local_user_playlist_metadata_entity.dart';

abstract class LocalUserPlaylistsTableProvider {
  Future<LocalUserPlaylistMetadataEntity?> getById(String id);

  Future<List<LocalUserPlaylistMetadataEntity>> getByUserId(String userId);

  Future<LocalUserPlaylistMetadataEntity> create(
    LocalUserPlaylistMetadataEntity entity,
  );

  Future<LocalUserPlaylistMetadataEntity> update(
    LocalUserPlaylistMetadataEntity entity,
  );

  Future<void> delete(String id);
}
