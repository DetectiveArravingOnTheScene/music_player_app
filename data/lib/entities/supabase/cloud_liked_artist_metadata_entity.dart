import 'package:core/core.dart';

import '../abstract/liked_artist_metadata_entity.dart';

part 'gen/cloud_liked_artist_metadata_entity.freezed.dart';
part 'gen/cloud_liked_artist_metadata_entity.g.dart';

@Freezed()
abstract class CloudLikedArtistMetadataEntity
    with _$CloudLikedArtistMetadataEntity
    implements LikedArtistMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CloudLikedArtistMetadataEntity({
    required String urn,
    required String userId,
    required int listenCount,
    required DateTime createdAt,
  }) = _CloudLikedArtistMetadataEntity;

  factory CloudLikedArtistMetadataEntity.fromJson(Map<String, dynamic> json) =>
      _$CloudLikedArtistMetadataEntityFromJson(json);
}
