import 'artist_entity.dart';
import 'track_entity.dart';

class PlaylistEntity {
  final String urn;
  final String? artworkUrl;
  final DateTime releaseDate;
  final int duration;
  final String? genre;
  final int likesCount;
  final List<TrackEntity> tracks;
  final ArtistEntity artist;
  final String title;

  PlaylistEntity({
    required this.artworkUrl,
    required this.releaseDate,
    required this.duration,
    required this.genre,
    required this.likesCount,
    required this.tracks,
    required this.artist,
    required this.title,
    required this.urn,
  });
}
