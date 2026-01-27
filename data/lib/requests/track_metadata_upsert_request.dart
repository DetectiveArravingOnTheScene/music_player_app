class TrackMetadataUpsertRequest {
  final String urn;
  final String userId;
  final int listenCount;
  final DateTime? createdAt;

  TrackMetadataUpsertRequest({
    required this.urn,
    required this.userId,
    this.listenCount = 0,
    this.createdAt,
  });
}
