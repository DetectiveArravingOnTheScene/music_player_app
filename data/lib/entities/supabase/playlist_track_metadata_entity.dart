import 'package:core/core.dart';

part 'gen/playlist_track_metadata_entity.freezed.dart';
part 'gen/playlist_track_metadata_entity.g.dart';

@Freezed()
abstract class PlaylistTrackMetadataEntity with _$PlaylistTrackMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PlaylistTrackMetadataEntity({
    required String playlistId,
    required String urn,
    required int position,
    required DateTime addedAt,
  }) = _PlaylistTrackMetadataEntity;

  factory PlaylistTrackMetadataEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaylistTrackMetadataEntityFromJson(json);
}
