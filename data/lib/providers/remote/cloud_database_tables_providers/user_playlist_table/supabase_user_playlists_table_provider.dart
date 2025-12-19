import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/user_playlist_metadata_entity.dart';
import '../supabase_consts.dart';
import 'cloud_user_playlists_table_provider.dart';

class SupabaseUserPlaylistsTableProvider
    implements CloudUserPlaylistsTableProvider {
  final Supabase _db;

  SupabaseUserPlaylistsTableProvider({required Supabase supabase})
    : _db = supabase;

  static const String _table = 'user_playlists';

  @override
  Future<UserPlaylistMetadataEntity?> getById(String id) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq(SupabaseConsts.idField, id)
        .limit(1);

    if (response.isEmpty) return null;
    return UserPlaylistMetadataEntity.fromJson(response.first);
  }

  @override
  Future<List<UserPlaylistMetadataEntity>> getByUserId(String userId) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq(SupabaseConsts.userIdField, userId);

    return response
        .map<UserPlaylistMetadataEntity>(UserPlaylistMetadataEntity.fromJson)
        .toList();
  }

  @override
  Future<UserPlaylistMetadataEntity> create(
    UserPlaylistMetadataEntity entity,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .insert(entity.toJson())
        .select();

    return UserPlaylistMetadataEntity.fromJson(response.first);
  }

  @override
  Future<void> update(UserPlaylistMetadataEntity entity) async {
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
