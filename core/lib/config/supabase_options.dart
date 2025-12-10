import '../core.dart';

class SupabaseOptions {
  static final String projectUrl = dotenv.env['SupabaseProjectUrl']!;
  static final String publishibleKey = dotenv.env['SupabasePublishedKey']!;
}
