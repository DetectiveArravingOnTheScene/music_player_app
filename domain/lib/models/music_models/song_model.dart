import '../models.dart';

class SongModel {
  final String title;
  final List<ArtistModel> authors;
  final AlbumModel album;
  final SongPath path;

  SongModel({
    required this.title,
    required this.authors,
    required this.album,
    required this.path,
  });
}

class PlaylistModel {
  final String title;
  final String creator;
  final List<SongModel> songs;

  PlaylistModel({
    required this.title,
    required this.creator,
    required this.songs,
  });
}
