import 'package:domain/payloads/payloads.dart';

import '../../../entities/abstract/user_entity.dart';

abstract class AuthProvider {
  Stream<UserEntity?> get authStateChanges;

  Future<void> signInWithGoogle();

  Future<void> signInWithEmail(SignInWithEmailPayload input);

  Future<void> signUpWithEmail(SignInWithEmailPayload input);

  Future<void> signOut();
}
