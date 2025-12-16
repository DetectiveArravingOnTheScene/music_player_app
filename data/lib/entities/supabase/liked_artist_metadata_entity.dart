import 'package:core/core.dart';

part 'gen/liked_artist_metadata_entity.freezed.dart';
part 'gen/liked_artist_metadata_entity.g.dart';

@Freezed()
abstract class LikedArtistMetadataEntity with _$LikedArtistMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LikedArtistMetadataEntity({
    required String urn,
    required String userId,
    required int listenCount,
    required DateTime createdAt,
  }) = _LikedArtistMetadataEntity;

  factory LikedArtistMetadataEntity.fromJson(Map<String, dynamic> json) =>
      _$LikedArtistMetadataEntityFromJson(json);
}
