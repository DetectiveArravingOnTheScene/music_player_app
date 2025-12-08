import 'package:domain/domain.dart';

class SignOutUseCase extends FutureUseCaseNoParams<void> {
  SignOutUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<void> execute() async {
    try {
      return _authRepository.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
