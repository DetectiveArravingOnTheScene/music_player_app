import 'package:domain/models/music_models/artist_model.dart';
import 'package:domain/models/music_models/playlist_model.dart';
import 'package:domain/models/music_models/track_model.dart';

import '../entities/playlist_entity.dart';
import '../entities/supabase/liked_playlist_metadata_entity.dart';
import 'artist_mapper.dart';

class PlaylistMapper {
  static PlaylistModel toModel(
    PlaylistEntity entity, {
    LikedPlaylistMetadataEntity? likedData,
  }) {
    final ArtistModel creator = ArtistMapper.toModel(entity: entity.artist);
    return PlaylistModel(
      urn: entity.urn,
      title: entity.title,
      creator: creator,
      songs: <TrackModel>[],
      artworkUrl: entity.artworkUrl,
      genre: entity.genre,
      duration: entity.duration,
      releaseDate: entity.releaseDate,
      globalLikesCount: entity.likesCount,

      isLiked: likedData != null,
      userListenCount: likedData?.listenCount ?? 0,
      likedAt: likedData?.createdAt,
    );
  }

  static LikedPlaylistMetadataEntity toMeta(
    PlaylistModel model,
    String userId,
  ) {
    return LikedPlaylistMetadataEntity(
      urn: model.urn,
      userId: userId,
      listenCount: model.userListenCount,
      createdAt: DateTime.now(),
    );
  }
}
