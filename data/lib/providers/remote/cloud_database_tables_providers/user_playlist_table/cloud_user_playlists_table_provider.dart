import '../../../../entities/supabase/user_playlist_metadata_entity.dart';

abstract class CloudUserPlaylistsTableProvider {
  Future<UserPlaylistMetadataEntity?> getById(String id);

  Future<List<UserPlaylistMetadataEntity>> getByUserId(String userId);

  Future<UserPlaylistMetadataEntity> create(UserPlaylistMetadataEntity entity);

  Future<void> update(UserPlaylistMetadataEntity entity);

  Future<void> delete(String id);
}
