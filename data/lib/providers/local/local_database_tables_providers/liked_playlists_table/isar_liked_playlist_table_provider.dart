import 'package:isar_plus/isar_plus.dart';
import '../../../../entities/isar/local_liked_playlist_metadata_entity.dart';
import 'local_liked_playlist_table_provider.dart';

class IsarLikedPlaylistsTableProvider
    implements LocalLikedPlaylistsTableProvider {
  final Isar _isar;

  IsarLikedPlaylistsTableProvider(this._isar);

  @override
  Future<LocalLikedPlaylistMetadataEntity?> getByUrn(String urn) {
    return _isar.localLikedPlaylistMetadataEntitys
        .where()
        .urnEqualTo(urn)
        .findFirstAsync();
  }

  @override
  Future<List<LocalLikedPlaylistMetadataEntity>> getByUserId(String userId) {
    return _isar.localLikedPlaylistMetadataEntitys
        .where()
        .userIdEqualTo(userId)
        .findAllAsync();
  }

  @override
  Future<LocalLikedPlaylistMetadataEntity> create(
    LocalLikedPlaylistMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      entity.id = i.localLikedPlaylistMetadataEntitys.autoIncrement();
      i.localLikedPlaylistMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<LocalLikedPlaylistMetadataEntity> update(
    LocalLikedPlaylistMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      final LocalLikedPlaylistMetadataEntity? existing = i
          .localLikedPlaylistMetadataEntitys
          .where()
          .urnEqualTo(entity.urn)
          .findFirst();

      if (existing != null) {
        entity.id = existing.id;
      }
      i.localLikedPlaylistMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<void> delete(String urn) async {
    await _isar.writeAsync((Isar i) {
      i.localLikedPlaylistMetadataEntitys.where().urnEqualTo(urn).deleteAll();
    });
  }
}
