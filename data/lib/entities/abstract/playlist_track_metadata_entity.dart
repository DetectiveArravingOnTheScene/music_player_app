abstract interface class PlaylistTrackMetadataEntity {
  String get playlistId;
  String get urn;
  int get position;
  DateTime get addedAt;
}
