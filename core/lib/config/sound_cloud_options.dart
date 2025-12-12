import '../core.dart';

class SoundCloudOptions {
  static final String clientId = dotenv.env['SoundCloudClientId']!;
  static final String clientSecret = dotenv.env['SoundCloudClientSecret']!;
}
