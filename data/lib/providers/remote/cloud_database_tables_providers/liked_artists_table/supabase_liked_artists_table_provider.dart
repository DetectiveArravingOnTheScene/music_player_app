import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/liked_artist_metadata_entity.dart';
import 'cloud_liked_artists_table_provider.dart';

class SupabaseLikedArtistsTableProvider
    implements CloudLikedArtistsTableProvider {
  final Supabase _db;

  SupabaseLikedArtistsTableProvider({required Supabase supabase})
    : _db = supabase;
  static const String table = 'liked_artists';

  @override
  Future<LikedArtistMetadataEntity?> getById(String id) async {
    final Map<String, dynamic>? response = await _db.client
        .from(table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;

    return LikedArtistMetadataEntity.fromJson(response);
  }

  @override
  Future<List<LikedArtistMetadataEntity>> getByUserId(String userId) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(table)
        .select()
        .eq('user_id', userId);

    return response
        .map<LikedArtistMetadataEntity>(LikedArtistMetadataEntity.fromJson)
        .toList();
  }

  @override
  Future<LikedArtistMetadataEntity> create(
    LikedArtistMetadataEntity entity,
  ) async {
    final Map<String, dynamic> response = await _db.client
        .from(table)
        .insert(entity.toJson())
        .select()
        .single();

    return LikedArtistMetadataEntity.fromJson(response);
  }

  @override
  Future<void> update(LikedArtistMetadataEntity entity) async {
    await _db.client.from(table).update(entity.toJson()).eq('id', entity.id);
  }

  @override
  Future<void> delete(String id) async {
    await _db.client.from(table).delete().eq('id', id);
  }
}
