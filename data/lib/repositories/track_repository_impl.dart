import 'package:core/di/app_di.dart';
import 'package:core/localization/gen/strings.g.dart';
import 'package:domain/domain.dart';
import 'package:domain/errors/api_app_exception.dart';
import 'package:domain/services/auth_service.dart';

import '../entities/soundcloud/collection_entity.dart';
import '../entities/soundcloud/playlist_entity.dart';
import '../entities/soundcloud/track_entity.dart';
import '../entities/supabase/liked_track_metadata_entity.dart';
import '../mappers/liked_tracks_mapper.dart';
import '../mappers/track_mapper.dart';
import '../providers/remote/cloud_database_tables_providers/liked_tracks_table/cloud_liked_tracks_table_provider.dart';
import '../providers/remote/remote_music_provider/remote_music_provider.dart';

class TrackRepositoryImpl extends TrackRepository {
  final RemoteMusicProvider _remoteMusicProvider;
  final CloudLikedTracksTableProvider _likedSongsTableProvider;

  TrackRepositoryImpl({
    required RemoteMusicProvider remoteProvider,
    required CloudLikedTracksTableProvider localProvider,
  }) : _remoteMusicProvider = remoteProvider,
       _likedSongsTableProvider = localProvider;

  String? get _currentUserId {
    return serviceLocator.get<AuthService>().currentUser?.id;
  }

  @override
  Future<TrackModel> getTrack(String trackUrl) async {
    try {
      final TrackEntity trackEntity = await _remoteMusicProvider.getTrack(
        trackUrl,
      );

      LikedTrackMetadataEntity? likedMetadata;
      if (_currentUserId != null) {
        likedMetadata = await _likedSongsTableProvider.getByUrn(
          trackEntity.urn,
        );
      }

      return TrackMapper.toModel(trackEntity, likedData: likedMetadata);
    } catch (e) {
      throw ApiAppException(t.track.failedToFetch);
    }
  }

  @override
  Future<CollectionModel<TrackModel>> getRelatedTracks(String id) async {
    try {
      final CollectionEntity<TrackEntity> trackEntities =
          await _remoteMusicProvider.getRelatedTracks(id);

      return CollectionModel<TrackModel>(
        items: await _fetchLikes(trackEntities.collection),
        nextHref: trackEntities.nextHref,
      );
    } catch (e) {
      throw ApiAppException(t.track.failedToFetch);
    }
  }

  @override
  Future<CollectionModel<TrackModel>> searchTracks(
    SearchTracksPayload payload,
  ) async {
    try {
      final CollectionEntity<TrackEntity> trackEntities =
          await _remoteMusicProvider.searchTracks(payload);

      return CollectionModel<TrackModel>(
        items: await _fetchLikes(trackEntities.collection),
        nextHref: trackEntities.nextHref,
      );
    } catch (e) {
      throw ApiAppException(t.track.failedToFetch);
    }
  }

  @override
  Future<CollectionModel<TrackModel>> getTrendingTracks() async {
    try {
      final PlaylistEntity playlistEntity = await _remoteMusicProvider
          .getPlaylist(
            'soundcloud:playlists:1714689261',
          ); // Hardcoded value for official playlist "top 50 tracks in US";

      return CollectionModel<TrackModel>(
        items: await _fetchLikes(playlistEntity.tracks),
      );
    } catch (e) {
      throw ApiAppException(t.track.failedToFetch);
    }
  }

  @override
  Future<Map<StreamTypeEnum, String>> getTrackStream(String streamUrl) async {
    try {
      return _remoteMusicProvider.getTrackStreams(streamUrl);
    } catch (e) {
      throw ApiAppException(t.track.failedToStream);
    }
  }

  Future<List<TrackModel>> _fetchLikes(List<TrackEntity> tracks) async {
    if (tracks.isEmpty) return <TrackModel>[];

    final String? userId = _currentUserId;

    if (userId != null) {
      final List<LikedTrackMetadataEntity> allLiked =
          await _likedSongsTableProvider.getByUserId(userId);

      return LikedTracksMapper.mapLikedTracks(tracks, allLiked);
    }
    return tracks.map(TrackMapper.toModel).toList();
  }
}
