import '../../../../entities/supabase/liked_playlist_metadata_entity.dart';

abstract class CloudLikedPlaylistsTableProvider {
  Future<LikedPlaylistMetadataEntity?> getById(String id);

  Future<List<LikedPlaylistMetadataEntity>> getByUserId(String userId);

  Future<LikedPlaylistMetadataEntity> create(
    LikedPlaylistMetadataEntity entity,
  );

  Future<void> update(LikedPlaylistMetadataEntity entity);

  Future<void> delete(String id);
}
