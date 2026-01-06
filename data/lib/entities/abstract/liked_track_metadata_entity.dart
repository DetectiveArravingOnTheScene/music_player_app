abstract interface class LikedTrackMetadataEntity {
  String get urn;
  String get userId;
  int get listenCount;
  DateTime get createdAt;
}
