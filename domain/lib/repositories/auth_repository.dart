import 'package:domain/models/models.dart';

abstract class IAuthRepository {
  Stream<UserModel?> get user;

  // The actual actions
  Future<void> signInWithGoogle();
  Future<void> signOut();

  UserModel? get currentUser;
}
