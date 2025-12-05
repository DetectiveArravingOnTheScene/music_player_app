class SongPath {
  final SongProvider provider;
  final String path;
  SongPath({required this.provider, required this.path});
}

enum SongProvider { local, remote }
