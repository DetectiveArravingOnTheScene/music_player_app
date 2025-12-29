import '../../../../entities/supabase/liked_artist_metadata_entity.dart';

abstract class CloudLikedArtistsTableProvider {
  Future<LikedArtistMetadataEntity?> getByUrn(String urn);

  Future<List<LikedArtistMetadataEntity>> getByUserId(String userId);

  Future<LikedArtistMetadataEntity> create(LikedArtistMetadataEntity entity);

  Future<void> update(LikedArtistMetadataEntity entity);

  Future<void> delete(String urn);
}
