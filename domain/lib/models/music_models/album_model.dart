import '../models.dart';

class AlbumModel {
  final String urn;
  final String title;
  final ArtistModel artist;
  final String? artworkUrl;
  final String? description;
  final DateTime? releaseDate;
  final String? genre;
  final String? label;
  final int trackCount;
  final int duration;
  final bool isLiked;

  AlbumModel({
    required this.urn,
    required this.title,
    required this.artist,
    this.artworkUrl,
    this.description,
    this.releaseDate,
    this.genre,
    this.label,
    required this.trackCount,
    required this.duration,
    required this.isLiked,
  });
}
