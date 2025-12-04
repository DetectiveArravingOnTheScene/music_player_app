import 'dart:async';
import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthProvider extends IAuthProvider {
  SupabaseAuthProvider(this._supa, this._googleSignIn);

  final Supabase _supa;
  final GoogleSignIn _googleSignIn;

  @override
  Stream<User?> get authStateChanges =>
      _supa.client.auth.onAuthStateChange.map((e) => e.session?.user);

  @override
  User? get currentUser => _supa.client.auth.currentUser;

  @override
  Future<AuthResponse> signInWithEmain() async {
    return await _supa.client.auth.signInWithPassword(
      email: 'valid.email@supabase.io',
      password: 'example-password',
    );
  }

  @override
  Future<AuthResponse> signInWithGoogle() async {
    final googleUser = await _googleSignIn.attemptLightweightAuthentication();
    if (googleUser == null) {
      throw AuthException('Failed to sign in with Google.');
    }

    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(
          GoogleSignInOptions.scopes,
        ) ??
        await googleUser.authorizationClient.authorizeScopes(
          GoogleSignInOptions.scopes,
        );
    final idToken = googleUser.authentication.idToken;

    if (idToken == null) {
      throw AuthException('No ID Token found.');
    }
    return await _supa.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _supa.client.auth.signOut();
  }
}
