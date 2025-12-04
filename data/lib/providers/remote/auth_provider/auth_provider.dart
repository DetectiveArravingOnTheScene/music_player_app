import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthProvider {
  Stream<User?> get authStateChanges;

  Future<AuthResponse> signInWithGoogle();

  Future<AuthResponse> signInWithEmail(String email, String password);

  Future<void> signOut();
}
