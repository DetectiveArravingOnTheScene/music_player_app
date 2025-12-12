class UserPlaylistMetadataEntity {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final bool isPublic;
  final String? coverUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserPlaylistMetadataEntity({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.isPublic,
    this.coverUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserPlaylistMetadataEntity.fromJson(Map<String, dynamic> json) {
    return UserPlaylistMetadataEntity(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      isPublic: json['is_public'] as bool? ?? false,
      coverUrl: json['cover_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'is_public': isPublic,
      'cover_url': coverUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
