import 'package:core/core.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    required Status status,
    required String email,
    required String password,
    String? emailError,
    String? passwordError,
    String? errorMessage,
    @Default(false) bool isValid,
  }) = _AuthState;
}
