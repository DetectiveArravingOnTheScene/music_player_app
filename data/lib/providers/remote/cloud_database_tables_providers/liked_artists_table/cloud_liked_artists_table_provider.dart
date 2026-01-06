import '../../../../entities/supabase/cloud_liked_artist_metadata_entity.dart';

abstract class CloudLikedArtistsTableProvider {
  Future<CloudLikedArtistMetadataEntity?> getByUrn(String urn);

  Future<List<CloudLikedArtistMetadataEntity>> getByUserId(String userId);

  Future<CloudLikedArtistMetadataEntity> create(
    CloudLikedArtistMetadataEntity entity,
  );

  Future<void> update(CloudLikedArtistMetadataEntity entity);

  Future<void> delete(String urn);
}
