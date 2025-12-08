import 'package:data/data.dart';
import 'package:domain/payloads/payloads.dart';

abstract class AuthProvider {
  Stream<UserEntity?> get authStateChanges;

  Future<void> signInWithGoogle();

  Future<void> signInWithEmail(SignInWithEmailPayload input);

  Future<void> signUpWithEmail(SignInWithEmailPayload input);

  Future<void> signOut();
}
