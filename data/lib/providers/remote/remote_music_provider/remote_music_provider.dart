import 'package:domain/domain.dart';

import '../../../data.dart';
import '../../../entities/soundcloud/collection_entity.dart';
import '../../../entities/soundcloud/stream_enum.dart';

abstract class RemoteMusicProvider {
  Future<void> authenticate(String clientId, String clientSecret);

  Future<CollectionEntity<TrackEntity>> searchTracks(SearchTracksPayload query);

  Future<CollectionEntity<PlaylistEntity>> searchPlaylists(
    SearchPlaylistsPayload query,
  );

  Future<CollectionEntity<ArtistEntity>> searchArtists(
    SearchUsersPayload query,
  );

  Future<TrackEntity> getTrack(String trackUrn);

  Future<PlaylistEntity> getPlaylist(String playlistUrn);

  Future<CollectionEntity<TrackEntity>> getPlaylistTracks(String playlistUrn);

  Future<Map<StreamType, String>> getTrackStreams(String trackUrn);

  Future<CollectionEntity<TrackEntity>> getRelatedTracks(String trackUrn);

  Future<ArtistEntity> getArtist(String artistUrn);

  Future<CollectionEntity<ArtistEntity>> getArtistsPlaylists(
    String artistUrn,
    List<String> access,
    int limit,
  );

  Future<CollectionEntity<TrackEntity>> getArtistsTracks(
    String artistUrn,
    List<String> access,
    int limit,
  );
}
