class TrackEntity {
  final String id;
  final String title;
  final String? artworkUrl;
  final int duration;
  final String? genre;
  final String? streamUrl;
  final String userUrl;

  TrackEntity({
    required this.title,
    required this.artworkUrl,
    required this.duration,
    required this.genre,
    required this.streamUrl,
    required this.userUrl,
    required this.id,
  });
}
