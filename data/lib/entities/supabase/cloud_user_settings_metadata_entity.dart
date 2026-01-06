import 'package:core/core.dart';

import '../abstract/user_settings_metadata_entity.dart';

part 'gen/cloud_user_settings_metadata_entity.freezed.dart';
part 'gen/cloud_user_settings_metadata_entity.g.dart';

@Freezed()
abstract class CloudUserSettingsMetadataEntity
    with _$CloudUserSettingsMetadataEntity
    implements UserSettingsMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CloudUserSettingsMetadataEntity({
    required String userId,
    required Map<String, dynamic> settings,
    required DateTime updatedAt,
  }) = _CloudUserSettingsMetadataEntity;

  factory CloudUserSettingsMetadataEntity.fromJson(Map<String, dynamic> json) =>
      _$CloudUserSettingsMetadataEntityFromJson(json);
}
