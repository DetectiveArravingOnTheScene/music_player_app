abstract interface class LikedPlaylistMetadataEntity {
  String get urn;
  String get userId;
  int get listenCount;
  DateTime get createdAt;
}
