import 'package:domain/domain.dart';

class SignInWithGoogleUseCase extends FutureUseCaseNoParams<void> {
  SignInWithGoogleUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<void> execute() async {
    return _authRepository.signInWithGoogle();
  }
}
