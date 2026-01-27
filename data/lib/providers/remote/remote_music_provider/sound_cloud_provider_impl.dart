import 'dart:convert';

import 'package:core/config/app_config.dart';
import 'package:core/di/app_di.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

import '../../../entities/soundcloud/artist_entity.dart';
import '../../../entities/soundcloud/collection_entity.dart';
import '../../../entities/soundcloud/playlist_entity.dart';
import '../../../entities/soundcloud/track_entity.dart';
import '../../../mappers/soundcloud_stream_type_enum_mapper.dart';
import '../../../requests/auth_request.dart';
import '../../api_provider.dart';
import '../../api_provider_consts.dart';
import 'remote_music_provider.dart';
import 'sound_cloud_strings.dart';

class SoundCloudProviderImpl extends RemoteMusicProvider {
  final ApiProvider _api;

  SoundCloudProviderImpl(ApiProvider api) : _api = api {
    _api.setTokenRefresher(() async {
      return authenticate(
        serviceLocator.get<AppConfig>().soundCloudClientId,
        serviceLocator.get<AppConfig>().soundCloudClientSecret,
      );
    });
  }

  @override
  Future<String> authenticate(String clientId, String clientSecret) async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';

    final Response<dynamic> response = await _api.post(
      url: ApiProviderConsts.apiSecureUrl,
      data: authRequest,
      options: Options(
        headers: <String, String>{
          ApiProviderConsts.autorizationHeaderKey: basicAuth,
        },
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    final String accessToken = data[SoundCloudStrings.accessTokenKey] as String;

    final Map<String, String> headers = <String, String>{
      ApiProviderConsts.autorizationHeaderKey:
          ApiProviderConsts.autorizationHeaderBody(accessToken),
    };

    _api.addHeaders(headers);
    serviceLocator.get<AuthService>().setAuthHeader(headers);

    return accessToken;
  }

  @override
  Future<ArtistEntity> getArtist(String artistUrn) async {
    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.getArtistEndpoint(artistUrn),
    );
    return ArtistEntity.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<CollectionEntity<ArtistEntity>> getArtistsPlaylists(
    String artistUrn,
    List<String> access,
    int limit,
  ) async {
    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.getArtistsPlaylistsEndpoint(artistUrn),
      queryParameters: <String, dynamic>{
        SoundCloudStrings.queryLimitParam: limit,
        SoundCloudStrings.queryAccessParam: access.join(','),
      },
    );

    return CollectionEntity<ArtistEntity>.fromJson(
      response.data as Map<String, dynamic>,
      (dynamic json) => ArtistEntity.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<CollectionEntity<TrackEntity>> getArtistsTracks(
    String artistUrn,
    List<String> access,
    int limit,
  ) async {
    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.getArtistsTracksEndpoint(artistUrn),
      queryParameters: <String, dynamic>{
        SoundCloudStrings.queryLimitParam: limit,
        SoundCloudStrings.queryAccessParam: access.join(','),
      },
    );

    return CollectionEntity<TrackEntity>.fromJson(
      response.data as Map<String, dynamic>,
      (dynamic json) => TrackEntity.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<PlaylistEntity> getPlaylist(String playlistUrn) async {
    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.getPlaylistEndpoint(playlistUrn),
    );

    return PlaylistEntity.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<CollectionEntity<TrackEntity>> getPlaylistTracks(
    String playlistUrn,
  ) async {
    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.getPlaylistTracksEndpoint(playlistUrn),
    );

    return CollectionEntity<TrackEntity>.fromJson(
      response.data as Map<String, dynamic>,
      (dynamic json) => TrackEntity.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<TrackEntity> getTrack(String trackUrn) async {
    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.getTrackEndpoint(trackUrn),
    );

    return TrackEntity.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<CollectionEntity<TrackEntity>> getRelatedTracks(
    String trackUrn,
  ) async {
    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.getRelatedTracksEndpoint(trackUrn),
    );

    return CollectionEntity<TrackEntity>.fromJson(
      response.data as Map<String, dynamic>,
      (dynamic json) => TrackEntity.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Map<StreamTypeEnum, String>> getTrackStreams(String trackUrn) async {
    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.getTrackStreamsEndpoint(trackUrn),
    );

    final Map<StreamTypeEnum, String> streams = <StreamTypeEnum, String>{};
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;

    for (final MapEntry<String, dynamic> entry in data.entries) {
      final StreamTypeEnum? type = SoundCloudStreamTypeMapper.fromKey(
        entry.key,
      );
      if (type != null && entry.value is String) {
        streams[type] = entry.value as String;
      }
    }

    return streams;
  }

  @override
  Future<CollectionEntity<ArtistEntity>> searchArtists(
    SearchArtistsPayload query,
  ) async {
    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.usersEndpoint,
      queryParameters: <String, dynamic>{
        SoundCloudStrings.queryQParam: query.query,
        SoundCloudStrings.queryAccessParam: query.access?.join(','),
      },
    );

    return CollectionEntity<ArtistEntity>.fromJson(
      response.data as Map<String, dynamic>,
      (dynamic json) => ArtistEntity.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<CollectionEntity<PlaylistEntity>> searchPlaylists(
    SearchPlaylistsPayload query,
  ) async {
    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.playlistsEndpoint,
      queryParameters: <String, dynamic>{
        SoundCloudStrings.queryQParam: query.query,
        SoundCloudStrings.queryLimitParam: query.limit,
        SoundCloudStrings.queryAccessParam: query.access?.join(','),
      },
    );

    return CollectionEntity<PlaylistEntity>.fromJson(
      response.data as Map<String, dynamic>,
      (dynamic json) => PlaylistEntity.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<CollectionEntity<TrackEntity>> searchTracks(
    SearchTracksPayload query,
  ) async {
    String fmt(DateTime dt) =>
        dt.toIso8601String().replaceAll('T', ' ').split('.')[0];

    final Map<String, dynamic> params = <String, dynamic>{
      SoundCloudStrings.queryQParam: query.query,

      if (query.limit != null) SoundCloudStrings.queryLimitParam: query.limit,
      if (query.ids != null)
        SoundCloudStrings.queryIdsParam: query.ids!.join(','),
      if (query.urns != null)
        SoundCloudStrings.queryUrnsParam: query.urns!.join(','),
      if (query.genres != null)
        SoundCloudStrings.queryGenresParam: query.genres!.join(','),
      if (query.tags != null)
        SoundCloudStrings.queryTagsParam: query.tags!.join(','),
      if (query.access != null)
        SoundCloudStrings.queryAccessParam: query.access!.join(','),
      if (query.bpm != null)
        SoundCloudStrings.queryBpmParam: <String, dynamic>{
          SoundCloudStrings.queryFromKey: query.bpm!.$1,
          SoundCloudStrings.queryToKey: query.bpm!.$2,
        },
      if (query.duration != null)
        SoundCloudStrings.queryDurationParam: <String, dynamic>{
          SoundCloudStrings.queryFromKey: query.duration!.$1,
          SoundCloudStrings.queryToKey: query.duration!.$2,
        },
      if (query.createdAt != null)
        SoundCloudStrings.queryCreatedParam: <String, dynamic>{
          SoundCloudStrings.queryFromKey: fmt(query.createdAt!.$1),
          SoundCloudStrings.queryToKey: fmt(query.createdAt!.$2),
        },
    };

    final Response<dynamic> response = await _api.get(
      url: SoundCloudStrings.tracksEndpoint,
      queryParameters: params,
    );

    return CollectionEntity<TrackEntity>.fromJson(
      response.data as Map<String, dynamic>,
      (dynamic json) => TrackEntity.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<CollectionEntity<TrackEntity>> getNextTracksPage(String url) async {
    final Response<dynamic> response = await _api.get(url: url);

    return CollectionEntity<TrackEntity>.fromJson(
      response.data as Map<String, dynamic>,
      (dynamic json) => TrackEntity.fromJson(json as Map<String, dynamic>),
    );
  }
}
