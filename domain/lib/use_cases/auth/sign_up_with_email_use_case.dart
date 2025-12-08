import 'package:domain/domain.dart';

class SignUpWithEmailUseCase
    extends FutureUseCase<SignInWithEmailPayload, void> {
  SignUpWithEmailUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<void> execute(SignInWithEmailPayload input) async {
    try {
      return _authRepository.signUpWithEmail(input);
    } catch (e) {
      rethrow;
    }
  }
}
