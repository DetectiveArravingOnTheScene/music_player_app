import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/cloud_playlist_track_metadata_entity.dart';
import '../supabase_consts.dart';
import 'cloud_playlist_track_table_provider.dart';

class SupabasePlaylistTracksTableProvider
    implements CloudPlaylistTracksTableProvider {
  final Supabase _db;

  SupabasePlaylistTracksTableProvider({required Supabase supabase})
    : _db = supabase;

  static const String _table = 'playlist_tracks';

  @override
  Future<List<CloudPlaylistTrackMetadataEntity>> getByPlaylistId(
    String playlistId,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq(SupabaseConsts.playlistIdField, playlistId);

    return response
        .map<CloudPlaylistTrackMetadataEntity>(
          CloudPlaylistTrackMetadataEntity.fromJson,
        )
        .toList();
  }

  @override
  Future<CloudPlaylistTrackMetadataEntity> addTrack(
    CloudPlaylistTrackMetadataEntity entity,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .insert(entity.toJson())
        .select();

    return CloudPlaylistTrackMetadataEntity.fromJson(response.first);
  }

  @override
  Future<void> updateTrack(CloudPlaylistTrackMetadataEntity entity) async {
    await _db.client
        .from(_table)
        .update(entity.toJson())
        .eq(SupabaseConsts.playlistIdField, entity.playlistId)
        .eq(SupabaseConsts.urnField, entity.urn);
  }

  @override
  Future<void> removeTrack(String playlistId, String urn) async {
    await _db.client
        .from(_table)
        .delete()
        .eq(SupabaseConsts.playlistIdField, playlistId)
        .eq(SupabaseConsts.urnField, urn);
  }
}
