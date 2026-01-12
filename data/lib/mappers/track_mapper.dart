import 'package:domain/domain.dart';
import 'package:domain/models/music_models/track_type.dart';

import '../entities/abstract/liked_track_metadata_entity.dart';
import '../entities/isar/local_liked_track_metadata_entity.dart';
import '../entities/soundcloud/track_entity.dart';
import '../entities/supabase/cloud_liked_track_metadata_entity.dart';
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

  static CloudLikedTrackMetadataEntity toCloud(
    TrackModel model,
    String userId,
  ) {
    return CloudLikedTrackMetadataEntity(
      urn: model.urn,
      userId: userId,
      listenCount: model.userListenCount,
      createdAt: DateTime.now(),
    );
  }

  static LocalLikedTrackMetadataEntity toLocal(
    TrackModel model,
    String userId,
  ) {
    return LocalLikedTrackMetadataEntity(
      urn: model.urn,
      userId: userId,
      listenCount: model.userListenCount,
      createdAt: DateTime.now(),
      id: 1,
    );
  }
}
