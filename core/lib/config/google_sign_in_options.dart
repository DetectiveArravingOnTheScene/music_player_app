import '../core.dart';

class GoogleSignInOptions {
  static final String webClientId = dotenv.env['GoogleWebClientId']!;
  static final String iosClientId = dotenv.env['GoogleIosClientId']!;

  static const List<String> scopes = <String>['email', 'profile'];
}
