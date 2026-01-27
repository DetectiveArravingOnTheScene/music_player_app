import '../../../../entities/supabase/cloud_liked_track_metadata_entity.dart';
import '../../../../requests/track_metadata_upsert_request.dart';

abstract class CloudLikedTracksTableProvider {
  Future<CloudLikedTrackMetadataEntity?> getByUrn(String urn);

  Future<List<CloudLikedTrackMetadataEntity>> getByUserId(String userId);

  Future<List<CloudLikedTrackMetadataEntity>> getByUserIdAndUrns(
    String userId,
    List<String> urns,
  );

  Future<CloudLikedTrackMetadataEntity> create(
    TrackMetadataUpsertRequest request,
  );

  Future<void> update(TrackMetadataUpsertRequest request);

  Future<void> delete(String urn);
}
