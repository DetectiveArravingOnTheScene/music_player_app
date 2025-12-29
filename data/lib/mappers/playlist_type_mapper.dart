import 'package:domain/models/music_models/playlist_type.dart';

class PlaylistTypeMapper {
  static PlaylistType fromString(String type) {
    return PlaylistType.values.asNameMap()[type.toLowerCase()] ??
        PlaylistType.playlist;
  }
}
