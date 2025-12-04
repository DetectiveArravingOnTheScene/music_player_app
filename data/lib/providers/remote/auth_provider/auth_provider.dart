import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IAuthProvider {
  Stream<User?> get authStateChanges;
  Future<AuthResponse> signInWithGoogle();
  Future<AuthResponse> signInWithEmain();
  Future<void> signOut();
  User? get currentUser;
}
