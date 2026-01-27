import '../models.dart';

class TrackModel {
  final String urn;
  final String title;
  final int duration;
  final int playbackCount;
  final int likesCount;
  final ArtistModel artist;
  final bool isLiked;
  final int userListenCount;
  final TrackType type;
  final String? artworkUrl;
  final String? genre;

  TrackModel({
    required this.urn,
    required this.title,
    required this.duration,
    required this.playbackCount,
    required this.likesCount,
    required this.artist,
    required this.isLiked,
    required this.userListenCount,
    required this.type,
    this.artworkUrl,
    this.genre,
  });
}
