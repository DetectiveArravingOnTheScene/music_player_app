import 'dart:async';

import 'package:core/di/app_di.dart';
import 'package:core/localization/gen/strings.g.dart';
import 'package:domain/domain.dart';
import 'package:domain/errors/api_app_exception.dart';
import 'package:domain/services/auth_service.dart';

import '../entities/abstract/liked_track_metadata_entity.dart';
import '../entities/soundcloud/collection_entity.dart';
import '../entities/soundcloud/playlist_entity.dart';
import '../entities/soundcloud/track_entity.dart';
import '../mappers/liked_tracks_mapper.dart';
import '../mappers/track_mapper.dart';
import '../providers/local/local_database_tables_providers/liked_tracks_table/local_liked_tracks_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/liked_tracks_table/cloud_liked_tracks_table_provider.dart';
import '../providers/remote/remote_music_provider/remote_music_provider.dart';

class TrackRepositoryImpl extends TrackRepository {
  final RemoteMusicProvider _remoteMusicProvider;
  final CloudLikedTracksTableProvider _cloudLikedTracksProvider;
  final LocalLikedTracksTableProvider _localLikedTracksProvider;

  TrackRepositoryImpl({
    required RemoteMusicProvider remoteProvider,
    required CloudLikedTracksTableProvider cloudProvider,
    required LocalLikedTracksTableProvider localProvider,
  }) : _remoteMusicProvider = remoteProvider,
       _cloudLikedTracksProvider = cloudProvider,
       _localLikedTracksProvider = localProvider;

  String? get _currentUserId {
    return serviceLocator.get<AuthService>().currentUser?.id;
  }

  final StreamController<TrackModel> _trackUpdateController =
      StreamController<TrackModel>.broadcast();

  @override
  Stream<TrackModel> get trackUpdates => _trackUpdateController.stream;

  @override
  Future<TrackModel> getTrack(String trackUrl) async {
    try {
      final TrackEntity trackEntity = await _remoteMusicProvider.getTrack(
        trackUrl,
      );

      LikedTrackMetadataEntity? likedMetadata;
      if (_currentUserId != null) {
        likedMetadata = await _localLikedTracksProvider.getByUrn(
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

  @override
  Future<void> likeTrack(TrackModel track) async {
    final String? userId = _currentUserId;
    if (userId == null) {
      throw AuthAppException(t.error.loginRequiredError);
    }

    try {
      await _cloudLikedTracksProvider.create(
        TrackMapper.toCloud(track, userId),
      );
      await _localLikedTracksProvider.create(
        TrackMapper.toLocal(track, userId),
      );

      print("UPDATED TRACK");

      _trackUpdateController.add(track.copyWith(isLiked: true));
    } catch (e) {
      print("$e");
      throw ApiAppException(t.track.failedToUpdate);
    }
  }

  @override
  Future<void> removeLikeTrack(TrackModel track) async {
    final String? userId = _currentUserId;
    if (userId == null) {
      throw ApiAppException(t.error.loginRequiredError);
    }

    try {
      await _cloudLikedTracksProvider.delete(track.urn);
      await _localLikedTracksProvider.delete(track.urn);

      _trackUpdateController.add(track.copyWith(isLiked: false));
    } catch (e) {
      throw ApiAppException(t.track.failedToUpdate);
    }
  }

  Future<List<TrackModel>> _fetchLikes(List<TrackEntity> tracks) async {
    if (tracks.isEmpty) return <TrackModel>[];

    final String? userId = _currentUserId;

    if (userId != null) {
      final List<LikedTrackMetadataEntity> allLiked =
          await _localLikedTracksProvider.getByUserId(userId);

      return LikedTracksMapper.mapLikedTracks(tracks, allLiked);
    }
    return tracks.map(TrackMapper.toModel).toList();
  }

  @override
  void dispose() {
    _trackUpdateController.close();
  }

  @override
  Future<CollectionModel<TrackModel>> getNextPage(String nextUrl) async {
    try {
      final CollectionEntity<TrackEntity> trackEntities =
          await _remoteMusicProvider.getNextTracksPage(nextUrl);

      final List<TrackModel> mappedTracks = await _fetchLikes(
        trackEntities.collection,
      );

      return CollectionModel<TrackModel>(
        items: mappedTracks,
        nextHref: trackEntities.nextHref,
      );
    } catch (e) {
      throw ApiAppException(t.track.failedToFetch);
    }
  }
}
