import 'package:core/core.dart';

import 'artist_entity.dart';
import 'track_entity.dart';

part 'gen/playlist_entity.freezed.dart';
part 'gen/playlist_entity.g.dart';

@freezed
abstract class PlaylistEntity with _$PlaylistEntity {
  const factory PlaylistEntity({
    @JsonKey(name: 'created_at', fromJson: _parseDate)
    required DateTime releaseDate,
    @JsonKey(name: 'likes_count') required int likesCount,
    @JsonKey(name: 'track_count') required int totalTrackCount,
    @JsonKey(name: 'user') required ArtistEntity artist,
    required String urn,
    required int duration,
    required List<TrackEntity> tracks,
    required String title,
    String? genre,
    @JsonKey(name: 'artwork_url') String? artworkUrl,
    @JsonKey(name: 'release_day') int? releaseDay,
    @JsonKey(name: 'release_month') int? releaseMonth,
    @JsonKey(name: 'release_year') int? releaseYear,
  }) = _PlaylistEntity;

  factory PlaylistEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaylistEntityFromJson(json);
}

// Api returns data in odd format
DateTime _parseDate(String dateString) {
  final String formatted = dateString.replaceAll('/', '-');
  return DateTime.parse(formatted);
}
