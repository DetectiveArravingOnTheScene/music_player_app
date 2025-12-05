import 'package:domain/models/models.dart';

abstract class AuthRepository {
  Stream<UserModel?> get user;

  Future<void> signInWithGoogle();

  Future<void> signInWithEmail(String email, String password);

  Future<void> signOut();
}
