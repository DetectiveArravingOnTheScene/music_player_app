import 'package:isar_plus/isar_plus.dart';
import '../../../../entities/isar/local_liked_artist_metadata_entity.dart';
import 'local_liked_artist_table_provider.dart';

class IsarLikedArtistsTableProvider implements LocalLikedArtistsTableProvider {
  final Isar _isar;

  IsarLikedArtistsTableProvider(this._isar);

  @override
  Future<LocalLikedArtistMetadataEntity?> getByUrn(String urn) {
    return _isar.localLikedArtistMetadataEntitys
        .where()
        .urnEqualTo(urn)
        .findFirstAsync();
  }

  @override
  Future<List<LocalLikedArtistMetadataEntity>> getByUserId(String userId) {
    return _isar.localLikedArtistMetadataEntitys
        .where()
        .userIdEqualTo(userId)
        .findAllAsync();
  }

  @override
  Future<LocalLikedArtistMetadataEntity> create(
    LocalLikedArtistMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      entity.id = i.localLikedArtistMetadataEntitys.autoIncrement();
      i.localLikedArtistMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<LocalLikedArtistMetadataEntity> update(
    LocalLikedArtistMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      final LocalLikedArtistMetadataEntity? existing = i
          .localLikedArtistMetadataEntitys
          .where()
          .urnEqualTo(entity.urn)
          .findFirst();

      if (existing != null) {
        entity.id = existing.id;
      }
      i.localLikedArtistMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<void> delete(String urn) async {
    await _isar.writeAsync((Isar i) {
      i.localLikedArtistMetadataEntitys.where().urnEqualTo(urn).deleteAll();
    });
  }
}
