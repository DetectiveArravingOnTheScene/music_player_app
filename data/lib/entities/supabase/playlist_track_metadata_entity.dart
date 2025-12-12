class PlaylistTrackMetadataEntity {
  final String playlistId;
  final String urn;
  final int position;
  final DateTime? addedAt;

  PlaylistTrackMetadataEntity({
    required this.playlistId,
    required this.urn,
    required this.position,
    this.addedAt,
  });

  factory PlaylistTrackMetadataEntity.fromJson(Map<String, dynamic> json) {
    return PlaylistTrackMetadataEntity(
      playlistId: json['playlist_id'] as String,
      urn: json['urn'] as String,
      position: json['position'] as int? ?? 0,
      addedAt: json['added_at'] != null
          ? DateTime.parse(json['added_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'playlist_id': playlistId,
      'urn': urn,
      'position': position,
      'added_at': addedAt?.toIso8601String(),
    };
  }
}
