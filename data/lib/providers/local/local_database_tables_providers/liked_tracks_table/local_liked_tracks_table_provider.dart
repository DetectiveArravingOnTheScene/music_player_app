import '../../../../entities/isar/local_liked_track_metadata_entity.dart';
import '../../../../requests/track_metadata_upsert_request.dart';

abstract class LocalLikedTracksTableProvider {
  Future<LocalLikedTrackMetadataEntity?> getByUrn(String urn);

  Future<List<LocalLikedTrackMetadataEntity>> getByUserId(String userId);

  Future<LocalLikedTrackMetadataEntity> create(
    TrackMetadataUpsertRequest entity,
  );

  Future<LocalLikedTrackMetadataEntity> update(
    TrackMetadataUpsertRequest entity,
  );

  Future<void> delete(String urn);
}
