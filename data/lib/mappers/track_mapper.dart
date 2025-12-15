import 'package:domain/domain.dart';

import '../entities/supabase/liked_song_metadata_entity.dart';
import '../entities/track_entity.dart';
import 'artist_mapper.dart';

class TrackMapper {
  static TrackModel toModel(
    TrackEntity entity, {
    LikedSongMetadataEntity? likedData,
  }) {
    final ArtistModel artistModel = ArtistMapper.toModel(entity: entity.artist);

    final AlbumModel albumModel = AlbumModel(
      urn: entity.urn,
      title: entity.title,
      artist: artistModel,
      artworkUrl: entity.artworkUrl,
      trackCount: 1,
      duration: entity.duration,
      isLiked: likedData != null,
      genre: entity.genre,
    );

    return TrackModel(
      urn: entity.urn,
      title: entity.title,
      artworkUrl: entity.artworkUrl,
      duration: entity.duration,
      genre: entity.genre,
      authors: <ArtistModel>[artistModel],
      likesCount: entity.likesCount,
      playbackCount: entity.playbackCount,
      album: albumModel,
      path: TrackPath(
        provider: TrackProvider.remote,
        path: entity.streamUrl ?? '',
      ),

      isLiked: likedData != null,
      userListenCount: likedData?.listenCount ?? 0,
      likedAt: likedData?.createdAt,
    );
  }

  static LikedSongMetadataEntity toMeta(TrackModel model, String userId) {
    return LikedSongMetadataEntity(
      urn: model.urn,
      userId: userId,
      listenCount: model.userListenCount,
      createdAt: DateTime.now(),
    );
  }
}
