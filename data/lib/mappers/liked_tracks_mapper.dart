import 'package:domain/domain.dart';

import '../entities/abstract/liked_track_metadata_entity.dart';
import '../entities/soundcloud/track_entity.dart';
import 'track_mapper.dart';

class LikedTracksMapper {
  static List<TrackModel> mapLikedTracks(
    List<TrackEntity> tracks,
    List<LikedTrackMetadataEntity> allLiked,
  ) {
    final Map<String, LikedTrackMetadataEntity> likedMap =
        <String, LikedTrackMetadataEntity>{};

    for (final LikedTrackMetadataEntity item in allLiked) {
      likedMap[item.urn] = item;
    }

    return tracks.map<TrackModel>((TrackEntity track) {
      return TrackMapper.toModel(track, likedData: likedMap[track.urn]);
    }).toList();
  }
}
