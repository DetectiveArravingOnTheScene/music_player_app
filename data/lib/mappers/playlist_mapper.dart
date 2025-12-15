import 'package:domain/models/music_models/artist_model.dart';
import 'package:domain/models/music_models/playlist_model.dart';
import 'package:domain/models/music_models/track_model.dart';

import '../entities/playlist_entity.dart';
import '../entities/supabase/liked_playlist_metadata_entity.dart';

class PlaylistMapper {
  static PlaylistModel toModel(
    PlaylistEntity entity, {
    LikedPlaylistMetadataEntity? likedData,
  }) {
    // Create a partial ArtistModel since PlaylistEntity only has userUrl
    //TODO: Fix
    final ArtistModel creatorPlaceholder = ArtistModel(
      urn: entity.userUrl,
      name: 'Unknown',
      username: 'Unknown',
      globalLikesCount: 0,
      isLiked: false,
      userListenCount: 0,
    );

    return PlaylistModel(
      urn: entity.urn,
      title: entity.title,
      creator: creatorPlaceholder,
      songs: <TrackModel>[], // Populated separately via getPlaylistTracks
      artworkUrl: entity.artworkUrl,
      genre: entity.genre,
      duration: entity.duration,
      releaseDate: entity.releaseDate,
      globalLikesCount: entity.likesCount,

      // Map metadata fields
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
