import 'package:domain/models/music_models/playlist_type.dart';

class PlaylistTypeMapper {
  static PlaylistType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'album':
        return PlaylistType.album;
      case 'playlist':
        return PlaylistType.playlist;
      default:
        return PlaylistType.playlist;
    }
  }
}
