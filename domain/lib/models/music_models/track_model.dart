import '../models.dart';

class TrackModel {
  final String urn;
  final String title;
  final String? artworkUrl;
  final int playbackCount;
  final int likesCount;
  final int duration;
  final String? genre;
  final List<ArtistModel> authors;
  final AlbumModel album;
  final TrackPath path;

  final bool isLiked;
  final int userListenCount;
  final DateTime? likedAt;

  const TrackModel({
    required this.urn,
    required this.title,
    required this.artworkUrl,
    required this.duration,
    required this.genre,
    required this.authors,
    required this.album,
    required this.path,
    this.isLiked = false,
    this.userListenCount = 0,
    this.likedAt,
    required this.playbackCount,
    required this.likesCount,
  });
}
