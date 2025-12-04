import 'package:data/data.dart';
import 'package:domain/domain.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final IAuthProvider _authProvider;

  AuthRepositoryImpl(this._authProvider);

  @override
  Stream<UserModel?> get user {
    return _authProvider.authStateChanges.map((supabaseUser) {
      if (supabaseUser == null) return null;
      return UserMapper.toModel(supabaseUser);
    });
  }

  @override
  UserModel? get currentUser {
    final supabaseUser = _authProvider.currentUser;
    if (supabaseUser == null) return null;
    return UserMapper.toModel(supabaseUser);
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      await _authProvider.signInWithGoogle();
    } catch (e) {
      ///TODO: Replace with Failure when merged
      throw Exception();
    }
  }

  @override
  Future<void> signOut() async {
    _authProvider.signOut();
  }
}
