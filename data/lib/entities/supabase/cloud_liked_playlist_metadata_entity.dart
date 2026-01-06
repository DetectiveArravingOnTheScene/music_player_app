import 'package:core/core.dart';

import '../abstract/liked_artist_metadata_entity.dart';

part 'gen/cloud_liked_playlist_metadata_entity.freezed.dart';
part 'gen/cloud_liked_playlist_metadata_entity.g.dart';

@Freezed()
abstract class CloudLikedPlaylistMetadataEntity
    with _$CloudLikedPlaylistMetadataEntity
    implements LikedArtistMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CloudLikedPlaylistMetadataEntity({
    required String urn,
    required String userId,
    required int listenCount,
    required DateTime createdAt,
  }) = _CloudLikedPlaylistMetadataEntity;

  factory CloudLikedPlaylistMetadataEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$CloudLikedPlaylistMetadataEntityFromJson(json);
}
