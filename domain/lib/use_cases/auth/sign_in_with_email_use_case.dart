import '../../domain.dart';

class SignInWithEmailUseCase
    extends FutureUseCase<SignInWithEmailPayload, void> {
  SignInWithEmailUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<void> execute(SignInWithEmailPayload trackUrn) async {
    return _authRepository.signInWithEmail(trackUrn);
  }
}
