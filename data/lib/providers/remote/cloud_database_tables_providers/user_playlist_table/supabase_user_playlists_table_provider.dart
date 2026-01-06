import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/cloud_user_playlist_metadata_entity.dart';
import '../supabase_consts.dart';
import 'cloud_user_playlists_table_provider.dart';

class SupabaseUserPlaylistsTableProvider
    implements CloudUserPlaylistsTableProvider {
  final Supabase _db;

  SupabaseUserPlaylistsTableProvider({required Supabase supabase})
    : _db = supabase;

  static const String _table = 'user_playlists';

  @override
  Future<CloudUserPlaylistMetadataEntity?> getById(String id) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq(SupabaseConsts.idField, id)
        .limit(1);

    if (response.isEmpty) return null;
    return CloudUserPlaylistMetadataEntity.fromJson(response.first);
  }

  @override
  Future<List<CloudUserPlaylistMetadataEntity>> getByUserId(
    String userId,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq(SupabaseConsts.userIdField, userId);

    return response
        .map<CloudUserPlaylistMetadataEntity>(
          CloudUserPlaylistMetadataEntity.fromJson,
        )
        .toList();
  }

  @override
  Future<CloudUserPlaylistMetadataEntity> create(
    CloudUserPlaylistMetadataEntity entity,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .insert(entity.toJson())
        .select();

    return CloudUserPlaylistMetadataEntity.fromJson(response.first);
  }

  @override
  Future<void> update(CloudUserPlaylistMetadataEntity entity) async {
    await _db.client
        .from(_table)
        .update(entity.toJson())
        .eq(SupabaseConsts.idField, entity.id);
  }

  @override
  Future<void> delete(String id) async {
    await _db.client.from(_table).delete().eq(SupabaseConsts.idField, id);
  }
}
