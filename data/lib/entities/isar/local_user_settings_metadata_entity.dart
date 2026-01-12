import 'package:isar_plus/isar_plus.dart';

import '../abstract/user_settings_metadata_entity.dart';

part 'gen/local_user_settings_metadata_entity.g.dart';

@Collection()
class LocalUserSettingsMetadataEntity implements UserSettingsMetadataEntity {
  LocalUserSettingsMetadataEntity({required this.id});

  int id;

  @override
  @Index(unique: true)
  late String userId;

  @override
  late String settings;

  @override
  late DateTime updatedAt;
}
