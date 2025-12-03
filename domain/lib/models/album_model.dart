import 'package:domain/models/models.dart';

class AlbumModel {
  final String title;
  final List<SongModel> songs;
  final DateTime? releaseDate;
  final List<ArtistModel> authors;

  AlbumModel({
    required this.title,
    required this.songs,
    required this.authors,
    required this.releaseDate,
  });
}
