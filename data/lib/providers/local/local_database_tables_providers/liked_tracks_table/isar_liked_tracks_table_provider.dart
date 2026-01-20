import 'package:isar_plus/isar_plus.dart';
import '../../../../entities/isar/local_liked_track_metadata_entity.dart';
import 'local_liked_tracks_table_provider.dart';

class IsarLikedTracksTableProvider implements LocalLikedTracksTableProvider {
  final Isar _isar;

  IsarLikedTracksTableProvider(this._isar);

  @override
  Future<LocalLikedTrackMetadataEntity?> getByUrn(String urn) {
    return _isar.localLikedTrackMetadataEntitys
        .where()
        .urnEqualTo(urn)
        .findFirstAsync();
  }

  @override
  Future<List<LocalLikedTrackMetadataEntity>> getByUserId(String userId) {
    return _isar.localLikedTrackMetadataEntitys
        .where()
        .userIdEqualTo(userId)
        .findAllAsync();
  }

  @override
  Future<List<LocalLikedTrackMetadataEntity>> getByUserIdAndUrns(
    String userId,
    List<String> urns,
  ) {
    return _isar.localLikedTrackMetadataEntitys
        .where()
        .anyOf(
          urns,
          (
            QueryBuilder<
              LocalLikedTrackMetadataEntity,
              LocalLikedTrackMetadataEntity,
              QFilterCondition
            >
            q,
            String urn,
          ) => q.urnEqualTo(urn),
        )
        .and()
        .userIdEqualTo(userId)
        .findAllAsync();
  }

  @override
  Future<LocalLikedTrackMetadataEntity> create(
    LocalLikedTrackMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      entity.id = i.localLikedTrackMetadataEntitys.autoIncrement();
      i.localLikedTrackMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<LocalLikedTrackMetadataEntity> update(
    LocalLikedTrackMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      final LocalLikedTrackMetadataEntity? existing = i
          .localLikedTrackMetadataEntitys
          .where()
          .urnEqualTo(entity.urn)
          .findFirst();

      if (existing != null) {
        entity.id = existing.id;
      }
      i.localLikedTrackMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<void> delete(String urn) async {
    await _isar.writeAsync((Isar i) {
      i.localLikedTrackMetadataEntitys.where().urnEqualTo(urn).deleteAll();
    });
  }
}
