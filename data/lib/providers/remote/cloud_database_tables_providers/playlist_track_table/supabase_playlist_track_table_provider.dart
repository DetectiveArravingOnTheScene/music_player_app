import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/playlist_track_metadata_entity.dart';
import 'cloud_playlist_track_table_provider.dart';

class SupabasePlaylistTracksTableProvider
    implements CloudPlaylistTracksTableProvider {
  final Supabase _db;

  SupabasePlaylistTracksTableProvider({required Supabase supabase})
    : _db = supabase;

  static const String _table = 'playlist_tracks';

  @override
  Future<List<PlaylistTrackMetadataEntity>> getByPlaylistId(
    String playlistId,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq('playlist_id', playlistId);

    return response
        .map<PlaylistTrackMetadataEntity>(PlaylistTrackMetadataEntity.fromJson)
        .toList();
  }

  @override
  Future<PlaylistTrackMetadataEntity> addTrack(
    PlaylistTrackMetadataEntity entity,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .insert(entity.toJson())
        .select();

    return PlaylistTrackMetadataEntity.fromJson(response.first);
  }

  @override
  Future<void> updateTrack(PlaylistTrackMetadataEntity entity) async {
    await _db.client
        .from(_table)
        .update(entity.toJson())
        .eq('playlist_id', entity.playlistId)
        .eq('urn', entity.urn);
  }

  @override
  Future<void> removeTrack(String playlistId, String urn) async {
    await _db.client
        .from(_table)
        .delete()
        .eq('playlist_id', playlistId)
        .eq('urn', urn);
  }
}
