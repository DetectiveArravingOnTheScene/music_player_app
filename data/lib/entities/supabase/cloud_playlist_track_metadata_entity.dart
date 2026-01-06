import 'package:core/core.dart';

import '../abstract/playlist_track_metadata_entity.dart';

part 'gen/cloud_playlist_track_metadata_entity.freezed.dart';
part 'gen/cloud_playlist_track_metadata_entity.g.dart';

@Freezed()
abstract class CloudPlaylistTrackMetadataEntity
    with _$CloudPlaylistTrackMetadataEntity
    implements PlaylistTrackMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CloudPlaylistTrackMetadataEntity({
    required String playlistId,
    required String urn,
    required int position,
    required DateTime addedAt,
  }) = _CloudPlaylistTrackMetadataEntity;

  factory CloudPlaylistTrackMetadataEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$CloudPlaylistTrackMetadataEntityFromJson(json);
}
