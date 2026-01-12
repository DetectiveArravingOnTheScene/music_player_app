import 'package:isar_plus/isar_plus.dart';

import '../abstract/liked_artist_metadata_entity.dart';

part 'gen/local_liked_artist_metadata_entity.g.dart';

@Collection()
class LocalLikedArtistMetadataEntity implements LikedArtistMetadataEntity {
  LocalLikedArtistMetadataEntity({
    required this.urn,
    required this.userId,
    required this.listenCount,
    required this.createdAt,
    required this.id,
  });

  @override
  @Index(unique: true)
  late String urn;

  @override
  @Index()
  late String userId;

  @override
  int listenCount = 0;

  @override
  late DateTime createdAt;

  int id;
}
