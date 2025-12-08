import 'package:data/data.dart';
import 'package:domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthProvider _authProvider;

  AuthRepositoryImpl(this._authProvider);

  @override
  Stream<UserModel?> get user {
    return _authProvider.authStateChanges.map((userEntity) {
      if (userEntity == null) {
        return null;
      }

      return UserMapper.toModel(userEntity);
    });
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
  Future<void> signInWithEmail(SignInWithEmailPayload input) async {
    try {
      await _authProvider.signInWithEmail(input);
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
