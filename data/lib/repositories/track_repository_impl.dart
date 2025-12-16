import 'package:core/di/app_di.dart';
import 'package:domain/models/music_models/track_model.dart';
import 'package:domain/payloads/search_tracks_payload.dart';
import 'package:domain/repositories/track_repository.dart';
import 'package:domain/services/auth_service.dart';

import '../entities/soundcloud/track_entity.dart';
import '../entities/supabase/liked_song_metadata_entity.dart';
import '../mappers/track_mapper.dart';
import '../providers/remote/cloud_database_tables_providers/liked_songs_table/cloud_liked_songs_table_provider.dart';
import '../providers/remote/remote_music_provider/remote_music_provider.dart';

class TrackRepositoryImpl extends TrackRepository {
  final RemoteMusicProvider _remoteMusicProvider;
  final CloudLikedSongsTableProvider _likedSongsTableProvider;

  TrackRepositoryImpl({
    required RemoteMusicProvider remoteProvider,
    required CloudLikedSongsTableProvider localProvider,
  }) : _remoteMusicProvider = remoteProvider,
       _likedSongsTableProvider = localProvider;

  String? get _currentUserId {
    return serviceLocator.get<AuthService>().currentUser?.id;
  }

  @override
  Future<TrackModel> getTrack(String trackUrl) async {
    final TrackEntity trackEntity = await _remoteMusicProvider.getTrack(
      trackUrl,
    );

    LikedSongMetadataEntity? likedMetadata;
    if (_currentUserId != null) {
      likedMetadata = await _likedSongsTableProvider.getByUrn(trackEntity.urn);
    }

    return TrackMapper.toModel(trackEntity, likedData: likedMetadata);
  }

  @override
  Future<List<TrackModel>> getRelatedTracks(String id) async {
    final List<TrackEntity> trackEntities = await _remoteMusicProvider
        .getRelatedTracks(id);
    return _mapCollectionWithLikes(trackEntities);
  }

  @override
  Future<List<TrackModel>> searchTracks(SearchTracksPayload payload) async {
    final List<TrackEntity> trackEntities = await _remoteMusicProvider
        .searchTracks(payload);

    return _mapCollectionWithLikes(trackEntities);
  }

  @override
  Future<String> getTrackStream(String streamUrl) async {
    final List<String> streams = await _remoteMusicProvider.getTrackStreams(
      streamUrl,
    );
    return streams.first;
  }

  Future<List<TrackModel>> _mapCollectionWithLikes(
    List<TrackEntity> tracks,
  ) async {
    if (tracks.isEmpty) return <TrackModel>[];

    final String? userId = _currentUserId;
    final Map<String, LikedSongMetadataEntity> likedMap =
        <String, LikedSongMetadataEntity>{};

    if (userId != null) {
      final List<LikedSongMetadataEntity> allLiked =
          await _likedSongsTableProvider.getByUserId(userId);
      for (final LikedSongMetadataEntity item in allLiked) {
        likedMap[item.urn] = item;
      }
    }

    return tracks.map((TrackEntity track) {
      return TrackMapper.toModel(track, likedData: likedMap[track.urn]);
    }).toList();
  }
}
