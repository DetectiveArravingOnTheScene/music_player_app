class SearchTracksPayload {
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

  SearchTracksPayload({
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
