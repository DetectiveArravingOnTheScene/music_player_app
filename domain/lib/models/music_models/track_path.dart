class TrackPath {
  final TrackProvider provider;
  final String path;
  TrackPath({required this.provider, required this.path});
}

enum TrackProvider { local, remote }
