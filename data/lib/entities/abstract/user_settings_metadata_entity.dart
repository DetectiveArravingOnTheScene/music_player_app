abstract interface class UserSettingsMetadataEntity {
  String get userId;
  Map<String, dynamic> get settings;
  DateTime get updatedAt;
}
