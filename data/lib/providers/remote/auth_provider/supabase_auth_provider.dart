import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data.dart';

class SupabaseAuthProvider implements AuthProvider {
  SupabaseAuthProvider(this._supabaseDb, this._googleSignIn);

  final Supabase _supabaseDb;

  final GoogleSignIn _googleSignIn;

  @override
  Stream<CloudUserEntity?> get authStateChanges =>
      _supabaseDb.client.auth.onAuthStateChange.map((AuthState state) {
        final User? user = state.session?.user;
        if (user == null) {
          return null;
        }

        return CloudUserEntity(
          id: user.id,
          email: user.email!,
          avatarUrl: user.userMetadata?['avatar_url'],
        );
      });

  @override
  Future<void> signInWithEmail(SignInWithEmailPayload input) async {
    await _supabaseDb.client.auth.signInWithPassword(
      email: input.email,
      password: input.password,
    );
  }

  @override
  Future<void> signUpWithEmail(SignInWithEmailPayload input) async {
    await _supabaseDb.client.auth.signUp(
      email: input.email,
      password: input.password,
    );
  }

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn
        .attemptLightweightAuthentication();
    if (googleUser == null) {
      throw AuthException(t.login.fail);
    }

    final GoogleSignInClientAuthorization authorization =
        await googleUser.authorizationClient.authorizationForScopes(
          serviceLocator.get<AppConfig>().googleScopes,
        ) ??
        await googleUser.authorizationClient.authorizeScopes(
          serviceLocator.get<AppConfig>().googleScopes,
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
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _supabaseDb.client.auth.signOut();
  }
}
