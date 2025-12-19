class SoundCloudStrings {
  static const String accessTokenKey = 'access_token';
  static const String queryLimitParam = 'limit';
  static const String queryAccessParam = 'access';
  static const String queryQParam = 'q';
  static const String queryIdsParam = 'ids';
  static const String queryUrnsParam = 'urns';
  static const String queryGenresParam = 'genres';
  static const String queryTagsParam = 'tags';

  static const String queryBpmParam = 'bpm';
  static const String queryDurationParam = 'duration';
  static const String queryCreatedParam = 'created_at';
  static const String queryFromKey = 'from';
  static const String queryToKey = 'to';

  static const String usersEndpoint = '/users';
  static const String playlistsEndpoint = '/playlists';
  static const String tracksEndpoint = '/tracks';

  static String getArtistEndpoint(String artistUrn) => '/users/$artistUrn';
  static String getArtistsPlaylistsEndpoint(String artistUrn) =>
      '/users/$artistUrn/playlists';
  static String getArtistsTracksEndpoint(String artistUrn) =>
      '/users/$artistUrn/tracks';

  static String getPlaylistEndpoint(String playlistUrn) =>
      '/playlists/$playlistUrn';
  static String getPlaylistTracksEndpoint(String playlistUrn) =>
      '/playlists/$playlistUrn/tracks';

  static String getTrackEndpoint(String trackUrn) => '/tracks/$trackUrn';
  static String getTrackStreamsEndpoint(String trackUrn) =>
      '/tracks/$trackUrn/streams';
  static String getRelatedTracksEndpoint(String trackUrn) =>
      '/tracks/$trackUrn/related';
}
