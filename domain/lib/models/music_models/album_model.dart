import '../models.dart';

class AlbumModel {
  final String title;
  final List<TrackModel> songs;
  final DateTime? releaseDate;
  final List<ArtistModel> authors;

  AlbumModel({
    required this.title,
    required this.songs,
    required this.authors,
    required this.releaseDate,
  });
}
