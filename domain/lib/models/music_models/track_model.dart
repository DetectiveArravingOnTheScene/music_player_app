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

  TrackModel copyWith({
    String? urn,
    String? title,
    int? duration,
    int? playbackCount,
    int? likesCount,
    ArtistModel? artist,
    bool? isLiked,
    int? userListenCount,
    TrackType? type,
    String? artworkUrl,
    String? genre,
  }) {
    return TrackModel(
      urn: urn ?? this.urn,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      playbackCount: playbackCount ?? this.playbackCount,
      likesCount: likesCount ?? this.likesCount,
      artist: artist ?? this.artist,
      isLiked: isLiked ?? this.isLiked,
      userListenCount: userListenCount ?? this.userListenCount,
      type: type ?? this.type,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      genre: genre ?? this.genre,
    );
  }
}
