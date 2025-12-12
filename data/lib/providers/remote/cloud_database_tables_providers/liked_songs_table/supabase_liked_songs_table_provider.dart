import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/liked_song_metadata_entity.dart';
import 'cloud_liked_songs_table_provider.dart';

class SupabaseLikedSongsTableProvider implements CloudLikedSongsTableProvider {
  final Supabase _db;

  SupabaseLikedSongsTableProvider({required Supabase supabase})
    : _db = supabase;

  static const String _table = 'liked_songs';

  @override
  Future<LikedSongMetadataEntity?> getById(String id) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq('id', id)
        .limit(1);

    if (response.isEmpty) return null;
    return LikedSongMetadataEntity.fromJson(response.first);
  }

  @override
  Future<List<LikedSongMetadataEntity>> getByUserId(String userId) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq('user_id', userId);

    return response
        .map<LikedSongMetadataEntity>(LikedSongMetadataEntity.fromJson)
        .toList();
  }

  @override
  Future<LikedSongMetadataEntity> create(LikedSongMetadataEntity entity) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .insert(entity.toJson())
        .select();

    return LikedSongMetadataEntity.fromJson(response.first);
  }

  @override
  Future<void> update(LikedSongMetadataEntity entity) async {
    await _db.client.from(_table).update(entity.toJson()).eq('id', entity.id);
  }

  @override
  Future<void> delete(String id) async {
    await _db.client.from(_table).delete().eq('id', id);
  }
}
