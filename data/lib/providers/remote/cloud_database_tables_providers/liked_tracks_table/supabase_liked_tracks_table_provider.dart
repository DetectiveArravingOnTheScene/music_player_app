import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/cloud_liked_track_metadata_entity.dart';
import '../supabase_consts.dart';
import 'cloud_liked_tracks_table_provider.dart';

class SupabaseLikedTracksTableProvider
    implements CloudLikedTracksTableProvider {
  final Supabase _db;

  SupabaseLikedTracksTableProvider({required Supabase supabase})
    : _db = supabase;

  static const String _table = 'liked_tracks';

  @override
  Future<CloudLikedTrackMetadataEntity?> getByUrn(String urn) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq(SupabaseConsts.urnField, urn)
        .limit(1);

    if (response.isEmpty) return null;
    return CloudLikedTrackMetadataEntity.fromJson(response.first);
  }

  @override
  Future<List<CloudLikedTrackMetadataEntity>> getByUserId(String userId) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq(SupabaseConsts.userIdField, userId);

    return response
        .map<CloudLikedTrackMetadataEntity>(
          CloudLikedTrackMetadataEntity.fromJson,
        )
        .toList();
  }

  @override
  Future<CloudLikedTrackMetadataEntity> create(
    CloudLikedTrackMetadataEntity entity,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .insert(entity.toJson())
        .select();

    return CloudLikedTrackMetadataEntity.fromJson(response.first);
  }

  @override
  Future<void> update(CloudLikedTrackMetadataEntity entity) async {
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
