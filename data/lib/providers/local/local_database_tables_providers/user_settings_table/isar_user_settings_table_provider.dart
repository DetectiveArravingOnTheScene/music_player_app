import 'package:isar_plus/isar_plus.dart';
import '../../../../entities/isar/local_user_settings_metadata_entity.dart';
import 'local_user_settings_table_provider.dart';

class IsarUserSettingsTableProvider implements LocalUserSettingsTableProvider {
  final Isar _isar;

  IsarUserSettingsTableProvider(this._isar);

  @override
  Future<LocalUserSettingsMetadataEntity?> getByUserId(String userId) {
    return _isar.localUserSettingsMetadataEntitys
        .where()
        .userIdEqualTo(userId)
        .findFirstAsync();
  }

  @override
  Future<LocalUserSettingsMetadataEntity> upsertSettings(
    LocalUserSettingsMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      final LocalUserSettingsMetadataEntity? existing = i
          .localUserSettingsMetadataEntitys
          .where()
          .userIdEqualTo(entity.userId)
          .findFirst();

      if (existing != null) {
        entity.id = existing.id;
      }

      i.localUserSettingsMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<void> deleteSettings(String userId) async {
    await _isar.writeAsync((Isar i) {
      i.localUserSettingsMetadataEntitys
          .where()
          .userIdEqualTo(userId)
          .deleteAll();
    });
  }
}
