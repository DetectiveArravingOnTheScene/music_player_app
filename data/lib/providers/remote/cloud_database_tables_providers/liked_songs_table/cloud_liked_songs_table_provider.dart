import '../../../../entities/supabase/liked_track_metadata_entity.dart';

abstract class CloudLikedSongsTableProvider {
  Future<LikedTrackMetadataEntity?> getByUrn(String urn);

  Future<List<LikedTrackMetadataEntity>> getByUserId(String userId);

  Future<LikedTrackMetadataEntity> create(LikedTrackMetadataEntity entity);

  Future<void> update(LikedTrackMetadataEntity entity);

  Future<void> delete(String urn);
}
