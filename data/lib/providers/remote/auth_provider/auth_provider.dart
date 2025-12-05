import 'package:data/data.dart';

abstract class AuthProvider {
  Stream<UserEntity?> get authStateChanges;

  Future<void> signInWithGoogle();

  Future<void> signInWithEmail(String email, String password);

  Future<void> signOut();
}
