import 'package:core/core.dart';

part 'gen/liked_playlist_metadata_entity.freezed.dart';
part 'gen/liked_playlist_metadata_entity.g.dart';

@Freezed()
abstract class LikedPlaylistMetadataEntity with _$LikedPlaylistMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LikedPlaylistMetadataEntity({
    required String urn,
    required String userId,
    required int listenCount,
    required DateTime createdAt,
  }) = _LikedPlaylistMetadataEntity;

  factory LikedPlaylistMetadataEntity.fromJson(Map<String, dynamic> json) =>
      _$LikedPlaylistMetadataEntityFromJson(json);
}
