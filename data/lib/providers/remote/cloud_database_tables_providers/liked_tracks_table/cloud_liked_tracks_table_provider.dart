import '../../../../entities/supabase/cloud_liked_track_metadata_entity.dart';

abstract class CloudLikedTracksTableProvider {
  Future<CloudLikedTrackMetadataEntity?> getByUrn(String urn);

  Future<List<CloudLikedTrackMetadataEntity>> getByUserId(String userId);

  Future<CloudLikedTrackMetadataEntity> create(
    CloudLikedTrackMetadataEntity entity,
  );

  Future<void> update(CloudLikedTrackMetadataEntity entity);

  Future<void> delete(String urn);
}
