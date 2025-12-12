class LikedArtistMetadataEntity {
  final String id;
  final String urn;
  final String userId;
  final int listenCount;
  final DateTime? createdAt;

  LikedArtistMetadataEntity({
    required this.id,
    required this.urn,
    required this.userId,
    required this.listenCount,
    this.createdAt,
  });

  factory LikedArtistMetadataEntity.fromJson(Map<String, dynamic> json) {
    return LikedArtistMetadataEntity(
      id: json['id'] as String,
      urn: json['urn'] as String,
      userId: json['user_id'] as String,
      listenCount: json['listen_count'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'urn': urn,
      'user_id': userId,
      'listen_count': listenCount,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
