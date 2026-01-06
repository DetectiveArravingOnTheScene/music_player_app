abstract interface class UserPlaylistMetadataEntity {
  String get id;
  String get userId;
  String get title;
  String? get description;
  bool get isPublic;
  String? get coverUrl;
  DateTime? get createdAt;
  DateTime? get updatedAt;
}
