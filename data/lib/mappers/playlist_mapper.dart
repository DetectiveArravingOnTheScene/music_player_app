import 'package:domain/models/music_models/collection_model.dart';
import 'package:domain/models/music_models/playlist_model.dart';
import 'package:domain/models/music_models/track_model.dart';

import '../entities/abstract/liked_playlist_metadata_entity.dart';
import '../entities/soundcloud/playlist_entity.dart';
import 'artist_mapper.dart';
import 'playlist_type_mapper.dart';
import 'track_mapper.dart';

class PlaylistMapper {
  static PlaylistModel toModel(
    PlaylistEntity entity, {
    LikedPlaylistMetadataEntity? likedData,
  }) {
    final CollectionModel<TrackModel> tracks = CollectionModel<TrackModel>(
      items: entity.tracks.map(TrackMapper.toModel).toList(),
    );

    return PlaylistModel(
      urn: entity.urn,
      title: entity.title,
      duration: entity.duration,
      createdAt: entity.releaseDate,
      globalLikesCount: entity.likesCount,
      totalTrackCount: entity.totalTrackCount,
      tracks: tracks,
      artist: ArtistMapper.toModel(entity: entity.artist),
      isLiked: likedData != null,
      userListenCount: likedData?.listenCount ?? 0,
      type: PlaylistTypeMapper.fromString(entity.type),
      artworkUrl: entity.artworkUrl,
      genre: entity.genre,
      releaseDay: entity.releaseDay,
      releaseMonth: entity.releaseMonth,
      releaseYear: entity.releaseYear,
    );
  }
}
