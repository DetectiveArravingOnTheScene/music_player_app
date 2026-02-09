import '../../domain.dart';

class SignUpWithEmailUseCase
    extends FutureUseCase<SignInWithEmailPayload, void> {
  SignUpWithEmailUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<void> execute(SignInWithEmailPayload trackUrn) async {
    return _authRepository.signUpWithEmail(trackUrn);
  }
}
