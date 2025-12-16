import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/liked_track_metadata_entity.dart';
import 'cloud_liked_tracks_table_provider.dart';

class SupabaseLikedTracksTableProvider
    implements CloudLikedTracksTableProvider {
  final Supabase _db;

  SupabaseLikedTracksTableProvider({required Supabase supabase})
    : _db = supabase;

  static const String _table = 'liked_tracks';

  @override
  Future<LikedTrackMetadataEntity?> getByUrn(String urn) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq('urn', urn)
        .limit(1);

    if (response.isEmpty) return null;
    return LikedTrackMetadataEntity.fromJson(response.first);
  }

  @override
  Future<List<LikedTrackMetadataEntity>> getByUserId(String userId) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq('user_id', userId);

    return response
        .map<LikedTrackMetadataEntity>(LikedTrackMetadataEntity.fromJson)
        .toList();
  }

  @override
  Future<LikedTrackMetadataEntity> create(
    LikedTrackMetadataEntity entity,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .insert(entity.toJson())
        .select();

    return LikedTrackMetadataEntity.fromJson(response.first);
  }

  @override
  Future<void> update(LikedTrackMetadataEntity entity) async {
    await _db.client.from(_table).update(entity.toJson()).eq('urn', entity.urn);
  }

  @override
  Future<void> delete(String urn) async {
    await _db.client.from(_table).delete().eq('urn', urn);
  }
}
