class UserSettingsMetadataEntity {
  final String userId;
  final Map<String, dynamic> settings;
  final DateTime? updatedAt;

  UserSettingsMetadataEntity({
    required this.userId,
    required this.settings,
    this.updatedAt,
  });

  factory UserSettingsMetadataEntity.fromJson(Map<String, dynamic> json) {
    return UserSettingsMetadataEntity(
      userId: json['user_id'] as String,
      settings:
          json['settings'] as Map<String, dynamic>? ?? <String, dynamic>{},
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'settings': settings,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
