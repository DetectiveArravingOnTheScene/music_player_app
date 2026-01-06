abstract interface class LikedArtistMetadataEntity {
  String get urn;
  String get userId;
  int get listenCount;
  DateTime get createdAt;
}
