import 'package:isar_plus/isar_plus.dart';
import '../../../../entities/isar/local_playlist_track_metadata_entity.dart';
import 'local_playlist_track_table_provider.dart';

class IsarPlaylistTracksTableProvider
    implements LocalPlaylistTracksTableProvider {
  final Isar _isar;

  IsarPlaylistTracksTableProvider(this._isar);

  @override
  Future<List<LocalPlaylistTrackMetadataEntity>> getByPlaylistId(
    String playlistId,
  ) {
    return _isar.localPlaylistTrackMetadataEntitys
        .where()
        .playlistIdEqualTo(playlistId)
        .findAllAsync();
  }

  @override
  Future<LocalPlaylistTrackMetadataEntity> addTrack(
    LocalPlaylistTrackMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      entity.id = i.localPlaylistTrackMetadataEntitys.autoIncrement();
      i.localPlaylistTrackMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<LocalPlaylistTrackMetadataEntity> updateTrack(
    LocalPlaylistTrackMetadataEntity entity,
  ) async {
    return _isar.writeAsync((Isar i) {
      final LocalPlaylistTrackMetadataEntity? existing = i
          .localPlaylistTrackMetadataEntitys
          .where()
          .playlistIdEqualTo(entity.playlistId)
          .urnEqualTo(entity.urn)
          .findFirst();

      if (existing != null) {
        entity.id = existing.id;
      }

      i.localPlaylistTrackMetadataEntitys.put(entity);
      return entity;
    });
  }

  @override
  Future<void> removeTrack(String playlistId, String urn) async {
    await _isar.writeAsync((Isar i) {
      i.localPlaylistTrackMetadataEntitys
          .where()
          .playlistIdEqualTo(playlistId)
          .urnEqualTo(urn)
          .deleteAll();
    });
  }
}
