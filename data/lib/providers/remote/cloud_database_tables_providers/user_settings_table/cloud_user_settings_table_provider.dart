import '../../../../entities/supabase/cloud_user_settings_metadata_entity.dart';

abstract class CloudUserSettingsTableProvider {
  Future<CloudUserSettingsMetadataEntity?> getByUserId(String userId);

  Future<void> upsertSettings(CloudUserSettingsMetadataEntity entity);

  Future<void> deleteSettings(String userId);
}
