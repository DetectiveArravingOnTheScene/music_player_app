import 'dart:async';
import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthProvider implements AuthProvider {
  SupabaseAuthProvider(this._supabaseDb, this._googleSignIn);

  final Supabase _supabaseDb;

  final GoogleSignIn _googleSignIn;

  @override
  Stream<User?> get authStateChanges =>
      _supabaseDb.client.auth.onAuthStateChange.map((e) => e.session?.user);

  @override
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    try {
      return await _supabaseDb.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .attemptLightweightAuthentication();
      if (googleUser == null) {
        throw AuthException('Failed to sign in with Google.');
      }

      final GoogleSignInClientAuthorization authorization =
          await googleUser.authorizationClient.authorizationForScopes(
            GoogleSignInOptions.scopes,
          ) ??
          await googleUser.authorizationClient.authorizeScopes(
            GoogleSignInOptions.scopes,
          );

      final String? idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        throw AuthException('No ID Token found.');
      }

      return await _supabaseDb.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _supabaseDb.client.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
