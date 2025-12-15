import 'package:core/di/app_di.dart';
import 'package:domain/models/music_models/track_model.dart';
import 'package:domain/repositories/track_repository.dart';
import 'package:domain/services/auth_service.dart';

import '../entities/supabase/liked_song_metadata_entity.dart';
import '../entities/track_entity.dart';
import '../mappers/track_mapper.dart';
import '../providers/remote/cloud_database_tables_providers/liked_songs_table/supabase_liked_songs_table_provider.dart';
import '../providers/remote/remote_music_provider/sound_cloud_provider.dart';
import '../requests/search_tracks_request.dart';

class TrackRepositoryImpl extends TrackRepository {
  final SoundCloudProvider _remoteProvider;
  final SupabaseLikedSongsTableProvider _localProvider;

  TrackRepositoryImpl({
    required SoundCloudProvider remoteProvider,
    required SupabaseLikedSongsTableProvider localProvider,
  }) : _remoteProvider = remoteProvider,
       _localProvider = localProvider;

  String? get _currentUserId {
    return serviceLocator.get<AuthService>().currentUser?.id;
  }

  @override
  Future<TrackModel> getTrack(String trackUrl) async {
    // 1. Fetch remote Entity
    final TrackEntity trackEntity = await _remoteProvider.getTrack(trackUrl);

    LikedSongMetadataEntity? likedMetadata;
    if (_currentUserId != null) {
      likedMetadata = await _localProvider.getByUrn(trackEntity.urn);
    }

    return TrackMapper.toModel(trackEntity, likedData: likedMetadata);
  }

  @override
  Future<List<TrackModel>> getRelatedTracks(String id) async {
    final List<TrackEntity> trackEntities = await _remoteProvider
        .getRelatedTracks(id);
    return _mapCollectionWithLikes(trackEntities);
  }

  @override
  Future<List<TrackModel>> searchTracks(
    String query, {
    int? limit,
    (int, int)? bpm,
    (int, int)? duration,
    List<String>? genres,
  }) async {
    // 1. Construct Request
    final SearchTracksRequest request = SearchTracksRequest(
      query: query,
      limit: limit,
      bpm: bpm,
      duration: duration,
      genres: genres,
    );

    // 2. Fetch Remote
    final List<TrackEntity> trackEntities = await _remoteProvider.searchTracks(
      request,
    );

    // 3. Map with Likes
    return _mapCollectionWithLikes(trackEntities);
  }

  @override
  Future<String> getTrackStream(String streamUrl) async {
    final List<String> streams = await _remoteProvider.getTrackStreams(
      streamUrl,
    );
    if (streams.isEmpty) {
      throw Exception('No valid streams found for this track.');
    }
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
      final List<LikedSongMetadataEntity> allLiked = await _localProvider
          .getByUserId(userId);
      for (final LikedSongMetadataEntity item in allLiked) {
        likedMap[item.urn] = item;
      }
    }

    return tracks.map((TrackEntity track) {
      return TrackMapper.toModel(track, likedData: likedMap[track.urn]);
    }).toList();
  }
}
