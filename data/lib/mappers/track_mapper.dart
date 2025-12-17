import 'package:domain/domain.dart';
import 'package:domain/models/music_models/track_type.dart';

import '../entities/soundcloud/track_entity.dart';
import '../entities/supabase/liked_track_metadata_entity.dart';
import 'artist_mapper.dart';

class TrackMapper {
  static TrackModel toModel(
    TrackEntity entity, {
    LikedTrackMetadataEntity? likedData,
  }) {
    return TrackModel(
      urn: entity.urn,
      title: entity.title,
      duration: entity.duration,
      playbackCount: entity.playbackCount,
      likesCount: entity.likesCount,
      artist: ArtistMapper.toModel(entity: entity.artist),
      isLiked: likedData != null,
      userListenCount: likedData?.listenCount ?? 0,
      type: TrackType.stream,
      artworkUrl: entity.artworkUrl,
      genre: entity.genre,
    );
  }

  static LikedTrackMetadataEntity toMeta(TrackModel model, String userId) {
    return LikedTrackMetadataEntity(
      urn: model.urn,
      userId: userId,
      listenCount: model.userListenCount,
      createdAt: DateTime.now(),
    );
  }
}
