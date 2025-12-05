import 'package:core/core.dart';

class GoogleSignInOptions {
  // static const String webClientId =
  //     '184659531066-l2s5p9cet414l3i2k9di1epq6bg472pi.apps.googleusercontent.com';

  // static const String iosClientId =
  //     '184659531066-2ok5v5qbjolf77v4jclobp9hmv4id2s0.apps.googleusercontent.com';

  static final String webClientId = dotenv.env['GoogleWebClientId']!;
  static final String iosClientId = dotenv.env['GoogleIosClientId']!;

  static const List<String> scopes = ['email', 'profile'];
}
