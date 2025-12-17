class ArtistModel {
  final String urn;
  final String username;
  final int followers;
  final bool isLiked;
  final int userListenCount;
  final String? avatarUrl;
  final String? city;
  final String? country;
  final String? description;

  ArtistModel({
    required this.urn,
    required this.username,
    required this.followers,
    required this.isLiked,
    required this.userListenCount,
    this.avatarUrl,
    this.city,
    this.country,
    this.description,
  });
}
