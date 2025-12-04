import 'package:data/data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthProvider extends AuthProvider {
  SupabaseAuthProvider({required this.supa});

  final Supabase supa;

  @override
  Future<void> meow() async {
    nativeGoogleSignIn();
  }

  Future<void> nativeGoogleSignIn() async {
    ///
    const webClientId =
        '184659531066-l2s5p9cet414l3i2k9di1epq6bg472pi.apps.googleusercontent.com';

    const iosClientId =
        '184659531066-2ok5v5qbjolf77v4jclobp9hmv4id2s0.apps.googleusercontent.com';
    final scopes = ['email', 'profile'];

    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(
      serverClientId: webClientId,
      clientId: iosClientId,
    );
    googleSignIn.signOut();

    final googleUser = await googleSignIn.attemptLightweightAuthentication();
    // or await googleSignIn.authenticate(); which will return a GoogleSignInAccount or throw an exception
    if (googleUser == null) {
      throw AuthException('Failed to sign in with Google.');
    }

    /// Authorization is required to obtain the access token with the appropriate scopes for Supabase authentication,
    /// while also granting permission to access user information.
    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
        await googleUser.authorizationClient.authorizeScopes(scopes);
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) {
      throw AuthException('No ID Token found.');
    }
    var res = await supa.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );

    print(res);
  }
}
