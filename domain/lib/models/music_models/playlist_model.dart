import '../models.dart';
import 'playlist_type.dart';

class PlaylistModel {
  final String urn;
  final String title;
  final int duration;
  final DateTime createdAt;
  final int globalLikesCount;
  final int totalTrackCount;
  final CollectionModel<TrackModel> tracks;
  final ArtistModel artist;
  final bool isLiked;
  final int userListenCount;
  final PlaylistType type;
  final String? artworkUrl;
  final String? genre;
  final int? releaseDay;
  final int? releaseMonth;
  final int? releaseYear;

  PlaylistModel({
    required this.urn,
    required this.title,
    required this.duration,
    required this.createdAt,
    required this.globalLikesCount,
    required this.totalTrackCount,
    required this.tracks,
    required this.artist,
    required this.isLiked,
    required this.userListenCount,
    required this.type,
    this.artworkUrl,
    this.genre,
    this.releaseDay,
    this.releaseMonth,
    this.releaseYear,
  });
}
