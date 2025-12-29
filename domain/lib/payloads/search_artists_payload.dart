class SearchArtistsPayload {
  final String query;
  final List<String>? access;
  final int? limit;

  SearchArtistsPayload({
    required this.query,
    this.access,
    this.limit,
  });
}
