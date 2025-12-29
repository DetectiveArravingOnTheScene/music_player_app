import 'package:domain/domain.dart';

import 'track_mapper.dart';

class LikedTracksMapper {
  static List<TrackModel> mapLikedTracks(
    List<TrackModel> tracks,
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
