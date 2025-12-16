import 'package:core/core.dart';

part 'gen/artist_entity.freezed.dart';
part 'gen/artist_entity.g.dart';

@freezed
abstract class ArtistEntity with _$ArtistEntity {
  const factory ArtistEntity({
    required String urn,
    required String username,
    @JsonKey(name: 'followers_count') required int followers,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? city,
    String? country,
    String? description,
    @JsonKey(name: 'full_name') String? fullName,
  }) = _ArtistEntity;

  factory ArtistEntity.fromJson(Map<String, dynamic> json) =>
      _$ArtistEntityFromJson(json);
}
