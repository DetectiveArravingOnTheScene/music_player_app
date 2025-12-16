class SearchPlaylistsPayload {
  final String query;
  final List<String>? access;
  final int? limit;

  SearchPlaylistsPayload({required this.query, this.access, this.limit});
}
