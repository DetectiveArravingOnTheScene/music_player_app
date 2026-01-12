import '../../../../entities/isar/local_liked_artist_metadata_entity.dart';

abstract class LocalLikedArtistsTableProvider {
  Future<LocalLikedArtistMetadataEntity?> getByUrn(String urn);

  Future<List<LocalLikedArtistMetadataEntity>> getByUserId(String userId);

  Future<LocalLikedArtistMetadataEntity> create(
    LocalLikedArtistMetadataEntity entity,
  );

  Future<LocalLikedArtistMetadataEntity> update(
    LocalLikedArtistMetadataEntity entity,
  );

  Future<void> delete(String urn);
}
