import 'package:domain/domain.dart';

class SignInWithEmailUseCase extends FutureUseCaseNoParams<void> {
  SignInWithEmailUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<void> execute() async {
    try {
      return _authRepository.signInWithGoogle();
    } catch (e) {
      rethrow;
    }
  }
}
