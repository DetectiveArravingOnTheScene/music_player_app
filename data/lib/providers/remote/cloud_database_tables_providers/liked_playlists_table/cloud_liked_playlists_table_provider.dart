import '../../../../entities/supabase/cloud_liked_playlist_metadata_entity.dart';

abstract class CloudLikedPlaylistsTableProvider {
  Future<CloudLikedPlaylistMetadataEntity?> getByUrn(String urn);

  Future<List<CloudLikedPlaylistMetadataEntity>> getByUserId(String userId);

  Future<CloudLikedPlaylistMetadataEntity> create(
    CloudLikedPlaylistMetadataEntity entity,
  );

  Future<void> update(CloudLikedPlaylistMetadataEntity entity);

  Future<void> delete(String urn);
}
