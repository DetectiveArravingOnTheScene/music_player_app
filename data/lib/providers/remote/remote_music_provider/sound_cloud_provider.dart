import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../entities/artist_entity.dart';
import '../../../entities/playlist_entity.dart';
import '../../../entities/track_entity.dart';
import '../../../requests/search_tracks_request.dart';
import '../../api_provider.dart';
import 'remote_music_provider.dart';

class SoundCloudProvider extends RemoteMusicProvider {
  final ApiProvider _api;

  SoundCloudProvider(ApiProvider api) : _api = api;

  @override
  Future<void> authenticate(String clientId, String clientSecret) async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';

    final Response<dynamic> response = await _api.post(
      url: 'https://secure.soundcloud.com/oauth/token',
      data: <String, String>{'grant_type': 'client_credentials'},
      options: Options(
        headers: <String, String>{'Authorization': basicAuth},
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    final String accessToken = data['access_token'] as String;

    _api.setAuthToken(accessToken);
  }

  @override
  Future<ArtistEntity> getArtist(String artistUrl) async {
    // Endpoint: /users/{user_urn}
    final Response<dynamic> response = await _api.get(url: '/users/$artistUrl');

    return _mapToArtistEntity(response.data);
  }

  @override
  Future<List<PlaylistEntity>> getArtistsPlaylists(
    String artistUrl,
    List<String> access,
    int limit,
  ) async {
    final Response<dynamic> response = await _api.get(
      url: '/users/$artistUrl/playlists',
      queryParameters: <String, dynamic>{'limit': limit},
    );

    return _mapCollection(response.data, _mapToPlaylistEntity);
  }

  @override
  Future<List<TrackEntity>> getArtistsTracks(
    String artistUrl,
    List<String> access,
    int limit,
  ) async {
    final Response<dynamic> response = await _api.get(
      url: '/users/$artistUrl/tracks',
      queryParameters: <String, dynamic>{
        'limit': limit,
        'access': access.join(','),
      },
    );

    return _mapCollection(response.data, _mapToTrackEntity);
  }

  @override
  Future<PlaylistEntity> getPlaylist(String playlistUrl) async {
    final Response<dynamic> response = await _api.get(
      url: '/playlists/$playlistUrl',
    );
    return _mapToPlaylistEntity(response.data);
  }

  @override
  Future<List<TrackEntity>> getRelatedTracks(String trackUrl) async {
    final Response<dynamic> response = await _api.get(
      url: '/tracks/$trackUrl/related',
    );
    return _mapCollection(response.data, _mapToTrackEntity);
  }

  @override
  Future<List<TrackEntity>> getPlaylistTracks(String playlistUrl) async {
    final Response<dynamic> response = await _api.get(
      url: '/playlists/$playlistUrl/tracks',
    );
    return _mapCollection(response.data, _mapToTrackEntity);
  }

  @override
  Future<TrackEntity> getTrack(String trackUrl) async {
    final Response<dynamic> response = await _api.get(url: '/tracks/$trackUrl');
    return _mapToTrackEntity(response.data);
  }

  @override
  Future<List<String>> getTrackStreams(String trackUrl) async {
    final Response<dynamic> response = await _api.get(
      url: '/tracks/$trackUrl/streams',
    );
    final dynamic data = response.data;

    if (data is Map<String, dynamic>) {
      // The endpoint returns an object with various stream URL keys (hls, http, etc.)
      // We extract all string values from the map.
      return data.values.whereType<String>().toList();
    }
    return <String>[];
  }

  @override
  Future<List<ArtistEntity>> searchArtists(SearchUsersRequest query) async {
    final dynamic response = await _api.get(
      url: '/users',
      queryParameters: <String, dynamic>{
        'q': query.query,
        if (query.limit != null) 'limit': query.limit,
      },
    );
    return _mapCollection(response.data, _mapToArtistEntity);
  }

  @override
  Future<List<PlaylistEntity>> searchPlaylists(
    SearchPlaylistsRequest query,
  ) async {
    final Response<dynamic> response = await _api.get(
      url: '/playlists',
      queryParameters: <String, dynamic>{
        'q': query.query,
        if (query.limit != null) 'limit': query.limit,
        if (query.access != null) 'access': query.access!.join(','),
      },
    );
    return _mapCollection(response.data, _mapToPlaylistEntity);
  }

  @override
  Future<List<TrackEntity>> searchTracks(SearchTracksRequest query) async {
    final Map<String, dynamic> params = <String, dynamic>{'q': query.query};

    if (query.limit != null) params['limit'] = query.limit;
    if (query.ids != null) params['ids'] = query.ids!.join(',');
    if (query.urns != null) params['urns'] = query.urns!.join(',');
    if (query.genres != null) params['genres'] = query.genres!.join(',');
    if (query.tags != null) params['tags'] = query.tags!.join(',');
    if (query.access != null) params['access'] = query.access!.join(',');

    if (query.bpm != null) {
      params['bpm[from]'] = query.bpm!.$1;
      params['bpm[to]'] = query.bpm!.$2;
    }

    if (query.duration != null) {
      params['duration[from]'] = query.duration!.$1;
      params['duration[to]'] = query.duration!.$2;
    }

    if (query.createdAt != null) {
      String fmt(DateTime dt) => dt.toIso8601String();
      params['created_at[from]'] = fmt(query.createdAt!.$1);
      params['created_at[to]'] = fmt(query.createdAt!.$2);
    }

    final Response<dynamic> response = await _api.get(
      url: '/tracks',
      queryParameters: params,
    );
    return _mapCollection(response.data, _mapToTrackEntity);
  }

  ArtistEntity _mapToArtistEntity(Map<String, dynamic> data) {
    final String city = data['city'] as String? ?? '';
    final String country = data['country'] as String? ?? '';
    final String location = <String>[
      city,
      country,
    ].where((String element) => element.isNotEmpty).join(', ');

    return ArtistEntity(
      urn: data['urn'] as String,
      avatarUrls: data['avatar_url'] as String?,
      location: location,
      description: data['description'] as String?,
      fullName: data['full_name'] as String?,
      likes: (data['public_favorites_count'] ?? 0) as int,
      username: data['username'] as String? ?? 'Unknown',
    );
  }

  PlaylistEntity _mapToPlaylistEntity(Map<String, dynamic> data) {
    // 1. Parse Date
    DateTime? date;
    if (data['release_year'] != null &&
        data['release_month'] != null &&
        data['release_day'] != null) {
      date = DateTime(
        (data['release_year'] as num).toInt(),
        (data['release_month'] as num).toInt(),
        (data['release_day'] as num).toInt(),
      );
    } else if (data['created_at'] != null) {
      String created = data['created_at'].toString();
      created = created.replaceAll('/', '-').split(' +')[0];
      created = created.replaceAll(' ', 'T');
      date = DateTime.tryParse(created);
    }
    // Fallback if date parsing fails
    date ??= DateTime.now();

    final Map<String, dynamic> userMap = data['user'] is Map<String, dynamic>
        ? data['user'] as Map<String, dynamic>
        : <String, dynamic>{};

    if (userMap.isEmpty && data.containsKey('user_urn')) {
      userMap['urn'] = data['user_urn'];
      userMap['username'] = 'Unknown Artist';
    }

    final ArtistEntity artist = _mapToArtistEntity(userMap);

    List<TrackEntity> tracks = <TrackEntity>[];
    if (data['tracks'] is List) {
      tracks = (data['tracks'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .map(_mapToTrackEntity)
          .whereType<TrackEntity>()
          .toList();
    }

    return PlaylistEntity(
      urn: (data['urn'] ?? '').toString(),
      artworkUrl: data['artwork_url'] as String?,
      releaseDate: date,
      duration: (data['duration'] ?? 0) as int,
      genre: data['genre'] as String?,
      likesCount: (data['likes_count'] ?? 0) as int,
      tracks: tracks,
      artist: artist,
      title: (data['title'] ?? 'Untitled').toString(),
    );
  }

  TrackEntity _mapToTrackEntity(Map<String, dynamic> data) {
    // Safety check: sometimes 'user' is null in restricted tracks
    final Map<String, dynamic> userObj = data['user'] is Map<String, dynamic>
        ? data['user'] as Map<String, dynamic>
        : <String, dynamic>{};

    final ArtistEntity artist = _mapToArtistEntity(userObj);

    return TrackEntity(
      urn: (data['urn'] ?? data['id']).toString(),
      title: (data['title'] ?? 'Unknown Track').toString(),
      artworkUrl: data['artwork_url'] as String?,
      duration: (data['duration'] ?? 0) as int,
      genre: data['genre'] as String?,
      streamUrl: data['stream_url'] as String?,
      artist: artist,
    );
  }

  List<T> _mapCollection<T>(
    dynamic responseData,
    T Function(Map<String, dynamic>) mapper,
  ) {
    List<dynamic> listData = <dynamic>[];

    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('collection')) {
      listData = responseData['collection'] as List<dynamic>;
    } else if (responseData is List) {
      listData = responseData;
    }

    return listData
        .whereType<Map<String, dynamic>>()
        .map((dynamic item) => mapper(item))
        .toList();
  }
}
