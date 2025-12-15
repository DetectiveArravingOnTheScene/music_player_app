class ArtistModel {
  final String urn;
  final String name;
  final String username;
  final String? avatarUrl;
  final String? location;
  final String? description;
  final int globalLikesCount;
  final bool isLiked;

  final int userListenCount;
  final DateTime? likedAt;

  ArtistModel({
    required this.name,
    required this.username,
    this.avatarUrl,
    this.location,
    this.description,
    required this.globalLikesCount,
    required this.isLiked,
    required this.userListenCount,
    this.likedAt,
    required this.urn,
  });
}
