import '../core.dart';

enum Flavor {
  prod,
  dev,
}

class AppConfig {
  final Flavor flavor;
  final String baseUrl;
  final String authUrl;
  final String webSocketUrl;

  final String supabaseUrl;
  final String supabasePublishibleKey;

  final String googleWebClientId;
  final String googleIosClientId;
  final List<String> googleScopes = <String>['email', 'profile'];

  AppConfig({
    required this.flavor,
    required this.baseUrl,
    required this.authUrl,
    required this.webSocketUrl,
    required this.supabaseUrl,
    required this.supabasePublishibleKey,
    required this.googleWebClientId,
    required this.googleIosClientId,
  });

  factory AppConfig.fromFlavor(Flavor flavor) {
    String baseUrl;
    String authUrl;
    String webSocketUrl;
    String supabaseUrl;
    String supabasePublishedKey;
    String googleWebClientId;
    String googleIosClientId;

    switch (flavor) {
      case Flavor.prod:
        baseUrl = 'https://api.soundcloud.com';
        authUrl = 'https://secure.soundcloud.com/oauth/token';
        webSocketUrl = '';
        supabaseUrl = dotenv.env['SupabaseProjectUrl'] ?? '';
        supabasePublishedKey = dotenv.env['SupabasePublishedKey'] ?? '';
        googleWebClientId = dotenv.env['GoogleWebClientId'] ?? '';
        googleIosClientId = dotenv.env['GoogleIosClientId'] ?? '';
        break;

      case Flavor.dev:
        baseUrl = 'https://api.soundcloud.com';
        authUrl = 'https://secure.soundcloud.com/oauth/token';
        webSocketUrl = '';
        supabaseUrl = dotenv.env['SupabaseProjectUrl'] ?? '';
        supabasePublishedKey = dotenv.env['SupabasePublishedKey'] ?? '';
        googleWebClientId = dotenv.env['GoogleWebClientId'] ?? '';
        googleIosClientId = dotenv.env['GoogleIosClientId'] ?? '';
        break;
    }

    return AppConfig(
      flavor: flavor,
      baseUrl: baseUrl,
      authUrl: authUrl,
      webSocketUrl: webSocketUrl,
      supabaseUrl: supabaseUrl,
      supabasePublishibleKey: supabasePublishedKey,
      googleWebClientId: googleWebClientId,
      googleIosClientId: googleIosClientId,
    );
  }
}
