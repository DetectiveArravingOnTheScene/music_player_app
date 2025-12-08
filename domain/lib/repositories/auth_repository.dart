import 'package:domain/domain.dart';

abstract class AuthRepository {
  Stream<UserModel?> get user;

  Future<void> signInWithGoogle();

  Future<void> signInWithEmail(SignInWithEmailPayload input);

  Future<void> signOut();
}
