import 'dart:io';

import 'package:isar_plus/isar_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../entities/isar/local_liked_artist_metadata_entity.dart';
import '../../entities/isar/local_liked_playlist_metadata_entity.dart';
import '../../entities/isar/local_liked_track_metadata_entity.dart';
import '../../entities/isar/local_playlist_track_metadata_entity.dart';
import '../../entities/isar/local_user_entity.dart';
import '../../entities/isar/local_user_playlist_metadata_entity.dart';
import '../../entities/isar/local_user_settings_metadata_entity.dart';

class IsarProvider {
  late final Isar _isar;

  Future<void> initialize() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.openAsync(
      schemas: <IsarGeneratedSchema>[
        LocalLikedArtistMetadataEntitySchema,
        LocalLikedPlaylistMetadataEntitySchema,
        LocalLikedTrackMetadataEntitySchema,
        LocalPlaylistTrackMetadataEntitySchema,
        LocalUserEntitySchema,
        LocalUserPlaylistMetadataEntitySchema,
        LocalUserSettingsMetadataEntitySchema,
      ],
      directory: dir.path,
    );
  }

  Isar get instance => _isar;
}
