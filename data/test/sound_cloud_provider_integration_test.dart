// ignore_for_file: avoid_print

import 'dart:io';

import 'package:core/core.dart';
import 'package:data/entities/artist_entity.dart';
import 'package:data/entities/playlist_entity.dart';
import 'package:data/entities/track_entity.dart';
import 'package:data/providers/api_provider.dart';
import 'package:data/providers/remote/remote_music_provider/sound_cloud_provider.dart';
import 'package:data/requests/search_tracks_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SoundCloudProvider provider;
  late ApiProvider apiProvider;

  setUpAll(() async {
    // Assuming you run tests from project root.
    // If .env is in root, just load it:
    final File envFile = File('api_keys.env');
    if (envFile.existsSync()) {
      final String env = await envFile.readAsString();
      dotenv.loadFromString(envString: env);
    } else {
      throw FileNotFoundError();
    }

    apiProvider = ApiProvider();
    provider = SoundCloudProvider(apiProvider);

    final String clientId = dotenv.env['SoundCloudClientId']!;
    final String clientSecret = dotenv.env['SoundCloudClientSecret']!;

    await provider.authenticate(clientId, clientSecret);
  });

  group('SoundCloudProvider Real API Integration Tests', () {
    // --- ARTIST TESTS ---
    test('getArtist returns real data for a known user', () async {
      final List<ArtistEntity> search = await provider.searchArtists(
        SearchUsersRequest(query: 'Monstercat', limit: 1),
      );
      expect(search, isNotEmpty, reason: 'Search should find "Monstercat"');

      expect(search.first.username, isNotNull);
    });

    test('searchTracks finds real tracks', () async {
      final SearchTracksRequest req = SearchTracksRequest(
        query: 'lofi',
        limit: 5,
      );
      final List<TrackEntity> tracks = await provider.searchTracks(req);

      expect(tracks.length, greaterThan(0));
      print('Found track: ${tracks.first.title}');

      // Verify parsing didn't crash on nulls
      expect(tracks.first.title, isNotEmpty);
    });

    test('searchPlaylists finds real playlists', () async {
      final SearchPlaylistsRequest req = SearchPlaylistsRequest(
        query: 'chill',
        limit: 5,
      );
      final List<PlaylistEntity> playlists = await provider.searchPlaylists(
        req,
      );

      expect(playlists.length, greaterThan(0));
      print('Found playlist: ${playlists.first.userUrl}');
    });

    // --- CHAINED TESTS (Use data from previous calls) ---

    test('Fetch Track details using ID from Search', () async {
      // 1. Search to get a valid ID (Real Integration)
      final List<TrackEntity> searchResults = await provider.searchTracks(
        SearchTracksRequest(query: 'skrillex', limit: 1),
      );

      expect(searchResults, isNotEmpty, reason: 'Search should return results');
      final TrackEntity firstTrack = searchResults.first;

      print(
        'Step 1: Found track "${firstTrack.title}" with ID: ${firstTrack.urn}',
      );
      expect(
        firstTrack.urn,
        isNotEmpty,
        reason: 'Track must have a valid URN/ID',
      );

      // 2. Use that ID to fetch full details
      final TrackEntity details = await provider.getTrack(firstTrack.urn);

      print('Step 2: Successfully fetched details for "${details.title}"');
      expect(details.title, equals(firstTrack.title));
    });

    // --- ROBUSTNESS TESTS ---

    test('Gracefully handles invalid IDs', () async {
      // We expect this to throw a DioException (404) or return null depending on your error handling.
      // Since your provider doesn't catch errors, it should throw.
      expect(
        () async => provider.getTrack('invalid-track-id-99999999'),
        throwsA(isA<Exception>()), // Likely DioException
      );
    });
  });
}
