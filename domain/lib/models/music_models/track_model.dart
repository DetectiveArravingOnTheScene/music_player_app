import '../models.dart';

class TrackModel {
  final String title;
  final String artworkUrl;
  final int duration;
  final String genre;
  final List<ArtistModel> authors;
  final AlbumModel album;
  final TrackPath path;

  TrackModel({
    required this.title,
    required this.authors,
    required this.album,
    required this.path,
    required this.artworkUrl,
    required this.duration,
    required this.genre,
  });
}
