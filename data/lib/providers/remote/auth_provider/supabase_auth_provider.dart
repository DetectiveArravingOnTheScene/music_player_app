import 'dart:async';
import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthProvider implements AuthProvider {
  SupabaseAuthProvider(this._supabaseDb, this._googleSignIn);

  final Supabase _supabaseDb;

  final GoogleSignIn _googleSignIn;

  @override
  Stream<UserEntity?> get authStateChanges =>
      _supabaseDb.client.auth.onAuthStateChange.map((state) {
        final User? user = state.session?.user;
        if (user == null) {
          return null;
        }

        return UserEntity(
          id: user.id,
          email: user.email!,
          avatarUrl: user.userMetadata?['avatar_url'],
        );
      });

  @override
  Future<void> signInWithEmail(SignInWithEmailPayload input) async {
    try {
      await _supabaseDb.client.auth.signInWithPassword(
        email: input.email,
        password: input.password,
      );
    } catch (e) {
      throw AuthAppException(t.login.fail);
    }
  }

  @override
  Future<void> signUpWithEmail(SignInWithEmailPayload input) async {
    try {
      await _supabaseDb.client.auth.signUp(
        email: input.email,
        password: input.password,
      );
    } catch (e) {
      throw AuthAppException(t.login.fail);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .attemptLightweightAuthentication();
      if (googleUser == null) {
        throw AuthException(t.login.fail);
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
        throw AuthException(t.login.fail);
      }

      await _supabaseDb.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthAppException(t.login.fail);
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
