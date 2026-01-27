import 'package:isar_plus/isar_plus.dart';

import '../abstract/playlist_track_metadata_entity.dart';

part 'gen/local_playlist_track_metadata_entity.g.dart';

@Collection()
@Index(composite: <String>['playlistId, urn'])
class LocalPlaylistTrackMetadataEntity implements PlaylistTrackMetadataEntity {
  LocalPlaylistTrackMetadataEntity({required this.id});

  int id;

  @override
  @Index()
  late String playlistId;

  @override
  late String urn;

  @override
  int position = 0;

  @override
  late DateTime addedAt;
}
