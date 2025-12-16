import 'package:core/core.dart';

part '../gen/liked_track_metadata_entity.freezed.dart';
part '../gen/liked_track_metadata_entity.g.dart';

@Freezed()
abstract class LikedTrackMetadataEntity with _$LikedTrackMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LikedTrackMetadataEntity({
    required String urn,
    required String userId,
    required int listenCount,
    required DateTime createdAt,
  }) = _LikedTrackMetadataEntity;

  factory LikedTrackMetadataEntity.fromJson(Map<String, dynamic> json) =>
      _$LikedTrackMetadataEntityFromJson(json);
}
