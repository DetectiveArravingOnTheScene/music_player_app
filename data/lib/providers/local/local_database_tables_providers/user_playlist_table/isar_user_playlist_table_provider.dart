import 'package:isar_plus/isar_plus.dart';
import '../../../../entities/isar/local_user_playlist_metadata_entity.dart';
import 'local_user_playlist_table_provider.dart';

class IsarUserPlaylistsTableProvider
    implements LocalUserPlaylistsTableProvider {
  final Isar _isar;

  IsarUserPlaylistsTableProvider(this._isar);

  @override
  Future<LocalUserPlaylistMetadataEntity?> getById(String id) {
    return _isar.localUserPlaylistMetadataEntitys
        .where()
        .idEqualTo(id)
        .findFirstAsync();
  }

  @override
  Future<List<LocalUserPlaylistMetadataEntity>> getByUserId(String userId) {
    return _isar.localUserPlaylistMetadataEntitys
        .where()
        .userIdEqualTo(userId)
        .findAllAsync();
  }

  @override
  Future<LocalUserPlaylistMetadataEntity> create(
    LocalUserPlaylistMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      i.localUserPlaylistMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<LocalUserPlaylistMetadataEntity> update(
    LocalUserPlaylistMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      i.localUserPlaylistMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<void> delete(String id) async {
    await _isar.writeAsync((Isar i) {
      i.localUserPlaylistMetadataEntitys.where().idEqualTo(id).deleteAll();
    });
  }
}
