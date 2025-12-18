import 'package:core/di/app_di.dart';
import 'package:core/localization/gen/strings.g.dart';
import 'package:domain/domain.dart';
import 'package:domain/errors/api_app_exception.dart';
import 'package:domain/models/music_models/collection_model.dart';
import 'package:domain/models/music_models/stream_type.dart';
import 'package:domain/services/auth_service.dart';

import '../entities/soundcloud/collection_entity.dart';
import '../entities/soundcloud/track_entity.dart';
import '../entities/supabase/liked_track_metadata_entity.dart';
import '../mappers/stream_type_mapper.dart';
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
        items: await _mapCollectionWithLikes(trackEntities.collection),
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
        items: await _mapCollectionWithLikes(trackEntities.collection),
        nextHref: trackEntities.nextHref,
      );
    } catch (e) {
      throw ApiAppException(t.track.failedToFetch);
    }
  }

  @override
  Future<Map<StreamType, String>> getTrackStream(String streamUrl) async {
    try {
      return StreamTypeMapper.mapToModel(
        await _remoteMusicProvider.getTrackStreams(streamUrl),
      );
    } catch (e) {
      throw ApiAppException(t.track.failedToStream);
    }
  }

  Future<List<TrackModel>> _mapCollectionWithLikes(
    List<TrackEntity> tracks,
  ) async {
    if (tracks.isEmpty) return <TrackModel>[];

    final String? userId = _currentUserId;
    final Map<String, LikedTrackMetadataEntity> likedMap =
        <String, LikedTrackMetadataEntity>{};

    if (userId != null) {
      final List<LikedTrackMetadataEntity> allLiked =
          await _likedSongsTableProvider.getByUserId(userId);
      for (final LikedTrackMetadataEntity item in allLiked) {
        likedMap[item.urn] = item;
      }
    }

    return tracks.map((TrackEntity track) {
      return TrackMapper.toModel(track, likedData: likedMap[track.urn]);
    }).toList();
  }
}
