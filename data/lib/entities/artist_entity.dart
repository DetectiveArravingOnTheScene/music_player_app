class ArtistEntity {
  final String urn;
  final String? avatarUrls;
  final String? location;
  final String? description;
  final String? fullName;
  final int likes;
  final String username;

  ArtistEntity({
    required this.avatarUrls,
    required this.location,
    required this.description,
    required this.fullName,
    required this.likes,
    required this.username,
    required this.urn,
  });
}
