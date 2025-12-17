import '../models.dart';

class PlaylistModel {
  final String urn;
  final String title;
  final ArtistModel creator;
  final List<TrackModel> songs;
  final String? artworkUrl;
  final String? genre;
  final int duration;
  final DateTime releaseDate;
  final int globalLikesCount;

  final bool isLiked;
  final int userListenCount;
  final DateTime? likedAt;

  const PlaylistModel({
    required this.urn,
    required this.title,
    required this.creator,
    required this.songs,
    required this.artworkUrl,
    required this.genre,
    required this.duration,
    required this.releaseDate,
    required this.globalLikesCount,
    this.isLiked = false,
    this.userListenCount = 0,
    this.likedAt,
  });
}
