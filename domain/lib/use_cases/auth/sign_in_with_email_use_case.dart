import 'package:domain/domain.dart';

class SignInWithEmailUseCase
    extends FutureUseCase<SignInWithEmailPayload, void> {
  SignInWithEmailUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<void> execute(SignInWithEmailPayload input) async {
    return _authRepository.signInWithEmail(input);
  }
}
