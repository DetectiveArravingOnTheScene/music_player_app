import 'package:core/core.dart';

class SupabaseOptions {
  // static const String projectUrl = 'https://jnkbhcmgjlwgfauzgzvp.supabase.co';

  // static const String publishibleKey =
  //     'sb_publishable_K8o73V7-TGKOgYPpY5VEsw_vyH8uEy7';

  static final String projectUrl = dotenv.env['SupabaseProjectUrl']!;
  static final String publishibleKey = dotenv.env['SupabasePublishedKey']!;
}
