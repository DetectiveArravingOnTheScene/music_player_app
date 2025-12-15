import 'package:domain/domain.dart';

import '../../../data.dart';

abstract class RemoteMusicProvider {
  Future<void> authenticate(String clientId, String clientSecret);

  Future<List<TrackEntity>> searchTracks(SearchTracksPayload query);

  Future<List<PlaylistEntity>> searchPlaylists(SearchPlaylistsPayload query);

  Future<List<ArtistEntity>> searchArtists(SearchUsersPayload query);

  Future<TrackEntity> getTrack(String trackUrl);

  Future<PlaylistEntity> getPlaylist(String playlistUrl);

  Future<List<TrackEntity>> getPlaylistTracks(String playlistUrl);

  Future<List<String>> getTrackStreams(String trackUrl);

  Future<List<TrackEntity>> getRelatedTracks(String trackUrl);

  Future<ArtistEntity> getArtist(String artistUrl);

  Future<List<PlaylistEntity>> getArtistsPlaylists(
    String artistUrl,
    List<String> access,
    int limit,
  );

  Future<List<TrackEntity>> getArtistsTracks(
    String artistUrl,
    List<String> access,
    int limit,
  );
}
