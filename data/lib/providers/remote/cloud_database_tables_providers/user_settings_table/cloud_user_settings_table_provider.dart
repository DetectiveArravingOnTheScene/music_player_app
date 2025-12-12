import '../../../../entities/supabase/user_settings_metadata_entity.dart';

abstract class CloudUserSettingsTableProvider {
  Future<UserSettingsMetadataEntity?> getByUserId(String userId);

  Future<void> upsertSettings(UserSettingsMetadataEntity entity);

  Future<void> deleteSettings(String userId);
}
