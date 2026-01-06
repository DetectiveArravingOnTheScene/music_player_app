import 'package:core/core.dart';

import '../abstract/user_playlist_metadata_entity.dart';

part 'gen/cloud_user_playlist_metadata_entity.freezed.dart';
part 'gen/cloud_user_playlist_metadata_entity.g.dart';

@Freezed()
abstract class CloudUserPlaylistMetadataEntity
    with _$CloudUserPlaylistMetadataEntity
    implements UserPlaylistMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CloudUserPlaylistMetadataEntity({
    required String id,
    required String userId,
    required String title,
    String? description,
    @Default(false) bool isPublic,
    String? coverUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CloudUserPlaylistMetadataEntity;

  factory CloudUserPlaylistMetadataEntity.fromJson(Map<String, dynamic> json) =>
      _$CloudUserPlaylistMetadataEntityFromJson(json);
}
