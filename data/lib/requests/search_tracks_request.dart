class SearchTracksRequest {
  final String query;
  final List<String>? ids;
  final List<String>? urns;
  final List<String>? genres;
  final List<String>? tags;
  final (int from, int to)? bpm;
  final (int from, int to)? duration;
  final (DateTime from, DateTime to)? createdAt;
  final List<String>? access;
  final int? limit;

  SearchTracksRequest({
    required this.query,
    this.ids,
    this.urns,
    this.genres,
    this.tags,
    this.bpm,
    this.duration,
    this.createdAt,
    this.access,
    this.limit,
  });
}

class SearchPlaylistsRequest {
  final String query;
  final List<String>? access;
  final int? limit;

  SearchPlaylistsRequest({required this.query, this.access, this.limit});
}

class SearchUsersRequest {
  final String query;
  final List<String>? access;
  final int? limit;

  SearchUsersRequest({required this.query, this.access, this.limit});
}
