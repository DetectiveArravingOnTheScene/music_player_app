import '../../../../entities/supabase/liked_song_metadata_entity.dart';

abstract class CloudLikedSongsTableProvider {
  Future<LikedSongMetadataEntity?> getByUrn(String urn);

  Future<List<LikedSongMetadataEntity>> getByUserId(String userId);

  Future<LikedSongMetadataEntity> create(LikedSongMetadataEntity entity);

  Future<void> update(LikedSongMetadataEntity entity);

  Future<void> delete(String urn);
}
