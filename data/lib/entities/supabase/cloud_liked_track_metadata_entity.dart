import 'package:core/core.dart';

import '../abstract/liked_track_metadata_entity.dart';

part 'gen/cloud_liked_track_metadata_entity.freezed.dart';
part 'gen/cloud_liked_track_metadata_entity.g.dart';

@Freezed()
abstract class CloudLikedTrackMetadataEntity
    with _$CloudLikedTrackMetadataEntity
    implements LikedTrackMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CloudLikedTrackMetadataEntity({
    required String urn,
    required String userId,
    required int listenCount,
    required DateTime createdAt,
  }) = _CloudLikedTrackMetadataEntity;

  factory CloudLikedTrackMetadataEntity.fromJson(Map<String, dynamic> json) =>
      _$CloudLikedTrackMetadataEntityFromJson(json);
}
