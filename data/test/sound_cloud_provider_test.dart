import 'package:data/entities/artist_entity.dart';
import 'package:data/entities/playlist_entity.dart';
import 'package:data/entities/track_entity.dart';
import 'package:data/providers/api_provider.dart';
import 'package:data/providers/remote/remote_music_provider/sound_cloud_provider.dart';
import 'package:data/requests/search_tracks_request.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockApiProvider extends Mock implements ApiProvider {}

void main() {
  late MockApiProvider mockApi;
  late SoundCloudProvider provider;

  setUpAll(() {
    registerFallbackValue(Options());
    registerFallbackValue(SearchUsersRequest(query: 'test'));
    registerFallbackValue(SearchPlaylistsRequest(query: 'test'));
    registerFallbackValue(SearchTracksRequest(query: 'test'));
  });

  setUp(() {
    mockApi = MockApiProvider();
    provider = SoundCloudProvider(mockApi);
  });

  Response<T> successResponse<T>(T data) {
    return Response<T>(
      data: data,
      requestOptions: RequestOptions(path: 'test'),
      statusCode: 200,
    );
  }

  group('SoundCloudProvider Unit Tests', () {
    // 1. AUTHENTICATION
    test('authenticate sends correct grant_type and Basic Auth', () async {
      final Map<String, Object> authResponse = <String, Object>{
        'access_token': 'access_token_123',
        'expires_in': 3600,
        'scope': '',
        'refresh_token': 'refresh_token_123',
        'token_type': 'bearer',
      };

      when(
        () => mockApi.post<Map<String, String>, dynamic>(
          url: any(named: 'url'),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => successResponse(authResponse));

      await provider.authenticate('id', 'secret');

      verify(
        () => mockApi.post(
          url: 'https://secure.soundcloud.com/oauth/token',
          data: <String, String>{'grant_type': 'client_credentials'},
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    // 2. ARTIST / USER
    group('SoundCloudProvider Tests', () {
      // ------------------------------------------------------------------------
      // AUTHENTICATION
      // ------------------------------------------------------------------------
      test('authenticate calls oauth endpoint and sets token', () async {
        const String clientId = 'client_123';
        const String clientSecret = 'secret_123';

        final Map<String, Object> authData = <String, Object>{
          'access_token': 'fake_access_token',
          'expires_in': 3600,
        };

        when(
          () => mockApi.post<Map<String, String>, dynamic>(
            url: any(named: 'url'),
            data: any(named: 'data'),
            options: any(named: 'options'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => successResponse(authData));

        await provider.authenticate(clientId, clientSecret);

        verify(
          () => mockApi.post(
            url: 'https://secure.soundcloud.com/oauth/token',
            data: <String, String>{'grant_type': 'client_credentials'},
            options: any(named: 'options'),
          ),
        ).called(1);

        verify(() => mockApi.setAuthToken('fake_access_token')).called(1);
      });

      // ------------------------------------------------------------------------
      // ARTIST TESTS
      // ------------------------------------------------------------------------
      test('getArtist returns mapped ArtistEntity with ID', () async {
        final Map<String, Object> json = <String, Object>{
          'urn': 'soundcloud:users:12345', // Added URN
          'username': 'TestUser',
          'full_name': 'Test User',
          'city': 'Berlin',
          'country': 'Germany',
          'public_favorites_count': 100,
          'avatar_url': 'http://avatar.com',
          'description': 'A test artist',
        };

        when(
          () => mockApi.get(url: '/users/user-urn-123'),
        ).thenAnswer((_) async => successResponse(json));

        final ArtistEntity result = await provider.getArtist('user-urn-123');

        expect(result.id, 'soundcloud:users:12345'); // Check ID mapping
        expect(result.username, 'TestUser');
        expect(result.location, 'Berlin, Germany');
        expect(result.likes, 100);
      });

      test(
        'getArtistsPlaylists returns list of PlaylistEntity with IDs',
        () async {
          final Map<String, List<Map<String, Object>>> json =
              <String, List<Map<String, Object>>>{
                'collection': <Map<String, Object>>[
                  <String, Object>{
                    'urn': 'soundcloud:playlists:1', // Added URN
                    'title': 'Playlist 1',
                    'duration': 1000,
                    'created_at': '2023/10/10 12:00:00 +0000',
                    'artwork_url': 'http://art.com/1.jpg',
                    'user': <String, String>{'urn': 'user:1'},
                  },
                  <String, Object>{
                    'urn': 'soundcloud:playlists:2', // Added URN
                    'title': 'Playlist 2',
                    'duration': 2000,
                    'created_at': '2023/10/11 12:00:00 +0000',
                    'artwork_url': 'http://art.com/2.jpg',
                    'user': <String, String>{'urn': 'user:1'},
                  },
                ],
              };

          when(
            () => mockApi.get(
              url: '/users/user-urn-123/playlists',
              queryParameters: any(named: 'queryParameters'),
            ),
          ).thenAnswer((_) async => successResponse(json));

          final List<PlaylistEntity> result = await provider
              .getArtistsPlaylists('user-urn-123', <String>[], 10);

          expect(result.length, 2);
          expect(result.first.id, 'soundcloud:playlists:1'); // Check ID mapping
          expect(result.first.duration, 1000);
          expect(result.first.title, 'Playlist 1');
        },
      );

      test('getArtistsTracks passes correct parameters', () async {
        final Map<String, List<dynamic>> json = <String, List<dynamic>>{
          'collection': <dynamic>[],
        };

        when(
          () => mockApi.get(
            url: any(named: 'url'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => successResponse(json));

        await provider.getArtistsTracks('user-urn', <String>[
          'access-1',
          'access-2',
        ], 5);

        verify(
          () => mockApi.get(
            url: '/users/user-urn/tracks',
            queryParameters: <String, dynamic>{
              'limit': 5,
              'access': 'access-1,access-2',
            },
          ),
        ).called(1);
      });

      // ------------------------------------------------------------------------
      // PLAYLIST TESTS
      // ------------------------------------------------------------------------
      test(
        'getPlaylist parses complex dates, ID and title correctly',
        () async {
          final Map<String, Object> json = <String, Object>{
            'urn': 'soundcloud:playlists:123', // Added URN
            'title': 'Test Playlist',
            'release_year': 2023,
            'release_month': 10,
            'release_day': 15,
            'duration': 5000,
            'tracks': <Map<String, String>>[
              <String, String>{'urn': 'track:1'},
              <String, String>{'urn': 'track:2'},
            ],
            'user': <String, String>{'urn': 'user:123'},
            'artwork_url': 'http://art.com',
            'label': 'somehting',
          };

          when(
            () => mockApi.get(url: '/playlists/playlist:1'),
          ).thenAnswer((_) async => successResponse(json));

          final PlaylistEntity result = await provider.getPlaylist(
            'playlist:1',
          );

          expect(result.id, 'soundcloud:playlists:123'); // Check ID mapping
          expect(result.title, 'Test Playlist');
          expect(result.releaseDate, DateTime(2023, 10, 15));
          expect(result.trackUrls, <String>['track:1', 'track:2']);
          expect(result.userUrl, 'user:123');
        },
      );

      test('getPlaylistTracks returns list of TrackEntity with IDs', () async {
        final Map<String, List<Map<String, Object>>> json =
            <String, List<Map<String, Object>>>{
              'collection': <Map<String, Object>>[
                <String, Object>{
                  'urn': 'soundcloud:tracks:99', // Added URN
                  'title': 'Track 1',
                  'duration': 123,
                  'artwork_url': 'http://art.com/track1.jpg',
                  'genre': 'Pop',
                },
              ],
            };

        when(
          () => mockApi.get(url: '/playlists/pl:1/tracks'),
        ).thenAnswer((_) async => successResponse(json));

        final List<TrackEntity> result = await provider.getPlaylistTracks(
          'pl:1',
        );
        expect(result.length, 1);
        expect(result.first.id, 'soundcloud:tracks:99'); // Check ID mapping
        expect(result.first.title, 'Track 1');
      });

      // ------------------------------------------------------------------------
      // TRACK TESTS
      // ------------------------------------------------------------------------
      test('getTrack returns TrackEntity with ID', () async {
        final Map<String, Object> json = <String, Object>{
          'urn': 'soundcloud:tracks:555', // Added URN
          'title': 'My Song',
          'duration': 300,
          'genre': 'Pop',
          'artwork_url': 'art.jpg',
          'user': <String, String>{'urn': 'user:1'},
        };

        when(
          () => mockApi.get(url: '/tracks/track:1'),
        ).thenAnswer((_) async => successResponse(json));

        final TrackEntity result = await provider.getTrack('track:1');

        expect(result.id, 'soundcloud:tracks:555'); // Check ID mapping
        expect(result.title, 'My Song');
        expect(result.userUrl, 'user:1');
      });

      test('getRelatedTracks returns list with IDs', () async {
        final List<Map<String, Object>> json = <Map<String, Object>>[
          <String, Object>{
            'urn': 'soundcloud:tracks:888', // Added URN
            'title': 'Related 1',
            'duration': 100,
            'artwork_url': 'related.jpg',
          },
        ];

        when(
          () => mockApi.get(url: '/tracks/track:1/related'),
        ).thenAnswer((_) async => successResponse(json));

        final List<TrackEntity> result = await provider.getRelatedTracks(
          'track:1',
        );
        expect(result.length, 1);
        expect(result.first.id, 'soundcloud:tracks:888'); // Check ID mapping
      });

      test('getTrackStreams extracts string values', () async {
        final Map<String, String> json = <String, String>{
          'hls': 'https://stream.hls',
          'http': 'https://stream.mp3',
          'preview': 'https://preview.mp3',
        };

        when(
          () => mockApi.get(url: '/tracks/track:1/streams'),
        ).thenAnswer((_) async => successResponse(json));

        final List<String> result = await provider.getTrackStreams('track:1');

        expect(result.length, 3);
        expect(result, contains('https://stream.hls'));
      });

      // ------------------------------------------------------------------------
      // SEARCH TESTS
      // ------------------------------------------------------------------------
      test('searchArtists passes query correctly', () async {
        when(
          () => mockApi.get(
            url: '/users',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => successResponse(<String, List<dynamic>>{
            'collection': <dynamic>[],
          }),
        );

        final SearchUsersRequest req = SearchUsersRequest(
          query: 'bob',
          limit: 20,
        );
        await provider.searchArtists(req);

        verify(
          () => mockApi.get(
            url: '/users',
            queryParameters: <String, dynamic>{'q': 'bob', 'limit': 20},
          ),
        ).called(1);
      });

      test('searchPlaylists passes access param correctly', () async {
        when(
          () => mockApi.get(
            url: '/playlists',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => successResponse(<String, List<dynamic>>{
            'collection': <dynamic>[],
          }),
        );

        final SearchPlaylistsRequest req = SearchPlaylistsRequest(
          query: 'lofi',
          access: <String>['playable', 'preview'],
        );
        await provider.searchPlaylists(req);

        verify(
          () => mockApi.get(
            url: '/playlists',
            queryParameters: <String, dynamic>{
              'q': 'lofi',
              'access': 'playable,preview',
            },
          ),
        ).called(1);
      });

      test(
        'searchTracks handles complex filters (BPM, Duration, CreatedAt)',
        () async {
          when(
            () => mockApi.get(
              url: '/tracks',
              queryParameters: any(named: 'queryParameters'),
            ),
          ).thenAnswer(
            (_) async => successResponse(<String, List<dynamic>>{
              'collection': <dynamic>[],
            }),
          );

          final DateTime start = DateTime(2023);
          final DateTime end = DateTime(2023, 12, 31);

          final SearchTracksRequest req = SearchTracksRequest(
            query: 'techno',
            genres: <String>['house', 'dub'],
            bpm: (120, 130),
            duration: (60000, 180000),
            createdAt: (start, end),
            limit: 50,
          );

          await provider.searchTracks(req);

          verify(
            () => mockApi.get(
              url: '/tracks',
              queryParameters: <String, dynamic>{
                'q': 'techno',
                'limit': 50,
                'genres': 'house,dub',
                'bpm[from]': 120,
                'bpm[to]': 130,
                'duration[from]': 60000,
                'duration[to]': 180000,
                'created_at[from]': start.toIso8601String(),
                'created_at[to]': end.toIso8601String(),
              },
            ),
          ).called(1);
        },
      );
    });

    test('getArtist parses Swagger-compliant User object', () async {
      final Map<String, Object?> json = <String, Object?>{
        'urn': 'soundcloud:users:12345', // Added URN
        'username': 'some.user',
        'full_name': 'Full Name',
        'city': 'City',
        'country': 'Country',
        'public_favorites_count': 20,
        'avatar_url': 'https://i1.sndcdn.com/avatars.jpg',
        'description': null,
      };

      when(
        () => mockApi.get(url: '/users/soundcloud:users:12345'),
      ).thenAnswer((_) async => successResponse(json));

      final ArtistEntity result = await provider.getArtist(
        'soundcloud:users:12345',
      );

      expect(result.id, 'soundcloud:users:12345'); // Check ID mapping
      expect(result.username, 'some.user');
      expect(result.location, 'City, Country');
      expect(result.likes, 20);
    });

    // 3. PLAYLISTS
    test('getPlaylist handles real Swagger date format (yyyy/mm/dd)', () async {
      final Map<String, Object> json = <String, Object>{
        'urn': 'soundcloud:playlists:123', // Added URN
        'title': 'Swagger Playlist',
        'duration': 11000,
        'created_at': '2020/07/16 16:09:54 +0000',
        'artwork_url': '',
        'tracks': <Map<String, String>>[
          <String, String>{'urn': 'soundcloud:tracks:1234'},
        ],
        'user': <String, String>{'urn': 'soundcloud:users:1234'},
      };

      when(
        () => mockApi.get(url: '/playlists/123'),
      ).thenAnswer((_) async => successResponse(json));

      final PlaylistEntity result = await provider.getPlaylist('123');

      expect(result.id, 'soundcloud:playlists:123'); // Check ID mapping
      expect(result.title, 'Swagger Playlist');
      expect(result.releaseDate, DateTime(2020, 07, 16, 16, 09, 54));
      expect(result.trackUrls, <String>['soundcloud:tracks:1234']);
    });

    // 4. TRACKS (The critical null check)
    test('getTrack handles NULL artwork_url safely', () async {
      final Map<String, Object?> json = <String, Object?>{
        'urn': 'soundcloud:tracks:555', // Added URN
        'title': 'Test drum sample',
        'duration': 40000,
        'genre': 'Pop',
        'artwork_url': null,
        'stream_url': 'https://api.soundcloud.com/tracks/1234/stream',
        'user': <String, String>{'urn': 'soundcloud:users:12345'},
      };

      when(
        () => mockApi.get(url: '/tracks/123'),
      ).thenAnswer((_) async => successResponse(json));

      final TrackEntity result = await provider.getTrack('123');

      expect(result.id, 'soundcloud:tracks:555'); // Check ID mapping
      expect(result.title, 'Test drum sample');
      expect(result.artworkUrl, null);
    });

    // 6. COLLECTIONS
    test('searchPlaylists correctly parses "collection" wrapper', () async {
      final Map<String, Object> json = <String, Object>{
        'collection': <Map<String, Object>>[
          <String, Object>{
            'urn': 'soundcloud:playlists:777', // Added URN
            'title': 'List Item 1',
            'duration': 100,
            'created_at': '2020/10/12 12:02:44 +0000',
            'user': <String, String>{'urn': 'u1'},
          },
        ],
        'next_href': 'https://api.soundcloud.com/next',
      };

      when(
        () => mockApi.get(
          url: '/playlists',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => successResponse(json));

      final List<PlaylistEntity> result = await provider.searchPlaylists(
        SearchPlaylistsRequest(query: 'test'),
      );

      expect(result.length, 1);
      expect(result.first.id, 'soundcloud:playlists:777'); // Check ID mapping
      expect(result.first.title, 'List Item 1');
    });
  });
}
