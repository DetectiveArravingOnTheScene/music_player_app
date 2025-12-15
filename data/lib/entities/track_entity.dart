import 'artist_entity.dart';

class TrackEntity {
  final String urn;
  final String title;
  final String? artworkUrl;
  final int duration;
  final String? genre;
  final String? streamUrl;
  final ArtistEntity artist;

  TrackEntity({
    required this.title,
    required this.artworkUrl,
    required this.duration,
    required this.genre,
    required this.streamUrl,
    required this.urn,
    required this.artist,
  });
}
