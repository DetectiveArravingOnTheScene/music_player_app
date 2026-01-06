import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/cloud_liked_playlist_metadata_entity.dart';
import '../supabase_consts.dart';
import 'cloud_liked_playlists_table_provider.dart';

class SupabaseLikedPlaylistsTableProvider
    implements CloudLikedPlaylistsTableProvider {
  final Supabase _db;

  SupabaseLikedPlaylistsTableProvider({required Supabase supabase})
    : _db = supabase;

  static const String _table = 'liked_playlists';

  @override
  Future<CloudLikedPlaylistMetadataEntity?> getByUrn(String urn) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq(SupabaseConsts.urnField, urn)
        .limit(1);

    if (response.isEmpty) return null;
    return CloudLikedPlaylistMetadataEntity.fromJson(response.first);
  }

  @override
  Future<List<CloudLikedPlaylistMetadataEntity>> getByUserId(
    String userId,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq(SupabaseConsts.userIdField, userId);

    return response
        .map<CloudLikedPlaylistMetadataEntity>(
          CloudLikedPlaylistMetadataEntity.fromJson,
        )
        .toList();
  }

  @override
  Future<CloudLikedPlaylistMetadataEntity> create(
    CloudLikedPlaylistMetadataEntity entity,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .insert(entity.toJson())
        .select();

    return CloudLikedPlaylistMetadataEntity.fromJson(response.first);
  }

  @override
  Future<void> update(CloudLikedPlaylistMetadataEntity entity) async {
    await _db.client
        .from(_table)
        .update(entity.toJson())
        .eq(SupabaseConsts.urnField, entity.urn);
  }

  @override
  Future<void> delete(String urn) async {
    await _db.client.from(_table).delete().eq(SupabaseConsts.urnField, urn);
  }
}
