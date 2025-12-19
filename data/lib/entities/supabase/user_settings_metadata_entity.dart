import 'package:core/core.dart';

part 'gen/user_settings_metadata_entity.freezed.dart';
part 'gen/user_settings_metadata_entity.g.dart';

@Freezed()
abstract class UserSettingsMetadataEntity with _$UserSettingsMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserSettingsMetadataEntity({
    required String userId,
    required Map<String, dynamic> settings,
    required DateTime updatedAt,
  }) = _UserSettingsMetadataEntity;

  factory UserSettingsMetadataEntity.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsMetadataEntityFromJson(json);
}
