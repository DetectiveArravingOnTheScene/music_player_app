import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/cloud_liked_artist_metadata_entity.dart';
import '../supabase_consts.dart';
import 'cloud_liked_artists_table_provider.dart';

class SupabaseLikedArtistsTableProvider
    implements CloudLikedArtistsTableProvider {
  final Supabase _db;

  SupabaseLikedArtistsTableProvider({required Supabase supabase})
    : _db = supabase;
  static const String table = 'liked_artists';

  @override
  Future<CloudLikedArtistMetadataEntity?> getByUrn(String urn) async {
    final Map<String, dynamic>? response = await _db.client
        .from(table)
        .select()
        .eq(SupabaseConsts.urnField, urn)
        .maybeSingle();

    if (response == null) return null;

    return CloudLikedArtistMetadataEntity.fromJson(response);
  }

  @override
  Future<List<CloudLikedArtistMetadataEntity>> getByUserId(
    String userId,
  ) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(table)
        .select()
        .eq(SupabaseConsts.userIdField, userId);

    return response
        .map<CloudLikedArtistMetadataEntity>(
          CloudLikedArtistMetadataEntity.fromJson,
        )
        .toList();
  }

  @override
  Future<CloudLikedArtistMetadataEntity> create(
    CloudLikedArtistMetadataEntity entity,
  ) async {
    final Map<String, dynamic> response = await _db.client
        .from(table)
        .insert(entity.toJson())
        .select()
        .single();

    return CloudLikedArtistMetadataEntity.fromJson(response);
  }

  @override
  Future<void> update(CloudLikedArtistMetadataEntity entity) async {
    await _db.client
        .from(table)
        .update(entity.toJson())
        .eq(SupabaseConsts.urnField, entity.urn);
  }

  @override
  Future<void> delete(String urn) async {
    await _db.client.from(table).delete().eq(SupabaseConsts.urnField, urn);
  }
}
