import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../entities/supabase/cloud_user_settings_metadata_entity.dart';
import '../supabase_consts.dart';
import 'cloud_user_settings_table_provider.dart';

class SupabaseUserSettingsTableProvider
    implements CloudUserSettingsTableProvider {
  final Supabase _db;

  SupabaseUserSettingsTableProvider({required Supabase supabase})
    : _db = supabase;

  static const String _table = 'user_settings';

  @override
  Future<CloudUserSettingsMetadataEntity?> getByUserId(String userId) async {
    final List<Map<String, dynamic>> response = await _db.client
        .from(_table)
        .select()
        .eq(SupabaseConsts.userIdField, userId)
        .limit(1);

    if (response.isEmpty) return null;
    return CloudUserSettingsMetadataEntity.fromJson(response.first);
  }

  @override
  Future<void> upsertSettings(CloudUserSettingsMetadataEntity entity) async {
    await _db.client
        .from(_table)
        .upsert(entity.toJson(), onConflict: SupabaseConsts.userIdField);
  }

  @override
  Future<void> deleteSettings(String userId) async {
    await _db.client
        .from(_table)
        .delete()
        .eq(SupabaseConsts.userIdField, userId);
  }
}
