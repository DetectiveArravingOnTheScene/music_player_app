import '../../../../entities/isar/local_user_settings_metadata_entity.dart';

abstract class LocalUserSettingsTableProvider {
  Future<LocalUserSettingsMetadataEntity?> getByUserId(String userId);

  Future<LocalUserSettingsMetadataEntity> upsertSettings(
    LocalUserSettingsMetadataEntity entity,
  );

  Future<void> deleteSettings(String userId);
}
