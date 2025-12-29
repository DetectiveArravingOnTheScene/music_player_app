import 'package:core/core.dart';

part 'gen/user_playlist_metadata_entity.freezed.dart';
part 'gen/user_playlist_metadata_entity.g.dart';

@Freezed()
abstract class UserPlaylistMetadataEntity with _$UserPlaylistMetadataEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserPlaylistMetadataEntity({
    required String id,
    required String userId,
    required String title,
    String? description,
    @Default(false) bool isPublic,
    String? coverUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserPlaylistMetadataEntity;

  factory UserPlaylistMetadataEntity.fromJson(Map<String, dynamic> json) =>
      _$UserPlaylistMetadataEntityFromJson(json);
}
