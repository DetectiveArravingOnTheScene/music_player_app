class ApiProviderStrings {
  static const String acceptHeaderKey = 'access';
  static const String acceptHeaderBody = 'application/json; charset=utf-8';

  static const String autorizationHeaderKey = 'Authorization';
  static String autorizationHeaderBody(String token) {
    return 'OAuth $token';
  }

  static const String apiBaseUrl = 'https://api.soundcloud.com';
  static const String apiSecureUrl =
      'https://secure.soundcloud.com/oauth/token';
}
