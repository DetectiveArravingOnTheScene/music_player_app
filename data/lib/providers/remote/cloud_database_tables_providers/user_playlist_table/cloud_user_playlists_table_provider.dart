import '../../../../entities/supabase/cloud_user_playlist_metadata_entity.dart';

abstract class CloudUserPlaylistsTableProvider {
  Future<CloudUserPlaylistMetadataEntity?> getById(String id);

  Future<List<CloudUserPlaylistMetadataEntity>> getByUserId(String userId);

  Future<CloudUserPlaylistMetadataEntity> create(
    CloudUserPlaylistMetadataEntity entity,
  );

  Future<void> update(CloudUserPlaylistMetadataEntity entity);

  Future<void> delete(String id);
}
