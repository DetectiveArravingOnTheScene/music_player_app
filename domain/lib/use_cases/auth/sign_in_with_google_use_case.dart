import 'package:domain/domain.dart';

class SignInWithGoogleUseCase extends FutureUseCaseNoParams<void> {
  SignInWithGoogleUseCase(this._authRepository);
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
