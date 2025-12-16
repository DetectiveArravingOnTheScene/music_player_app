import 'package:core/core.dart';
import 'artist_entity.dart';

part 'gen/track_entity.freezed.dart';
part 'gen/track_entity.g.dart';

@freezed
abstract class TrackEntity with _$TrackEntity {
  const factory TrackEntity({
    required String urn,
    required String title,
    required int duration,
    @JsonKey(name: 'playback_count') required int playbackCount,
    @JsonKey(name: 'favoritings_count') required int likesCount,
    @JsonKey(name: 'user') required ArtistEntity artist,
    @JsonKey(name: 'stream_url') required String streamUrl,
    @JsonKey(name: 'artwork_url') String? artworkUrl,
    String? genre,
  }) = _TrackEntity;

  factory TrackEntity.fromJson(Map<String, dynamic> json) =>
      _$TrackEntityFromJson(json);
}
