class PlaylistEntity {
  final String urn;
  final String? artworkUrl;
  final DateTime releaseDate;
  final int duration;
  final String? genre;
  final int likesCount;
  final List<String>? trackUrls;
  final String userUrl;
  final String title;

  PlaylistEntity({
    required this.artworkUrl,
    required this.releaseDate,
    required this.duration,
    required this.genre,
    required this.likesCount,
    required this.trackUrls,
    required this.userUrl,
    required this.title,
    required this.urn,
  });
}
