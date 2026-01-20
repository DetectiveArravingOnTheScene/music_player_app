import '../../../../entities/isar/local_liked_track_metadata_entity.dart';

abstract class LocalLikedTracksTableProvider {
  Future<LocalLikedTrackMetadataEntity?> getByUrn(String urn);

  Future<List<LocalLikedTrackMetadataEntity>> getByUserId(String userId);

  Future<List<LocalLikedTrackMetadataEntity>> getByUserIdAndUrns(
    String userId,
    List<String> urns,
  );

  Future<LocalLikedTrackMetadataEntity> create(
    LocalLikedTrackMetadataEntity entity,
  );

  Future<LocalLikedTrackMetadataEntity> update(
    LocalLikedTrackMetadataEntity entity,
  );

  Future<void> delete(String urn);
}
