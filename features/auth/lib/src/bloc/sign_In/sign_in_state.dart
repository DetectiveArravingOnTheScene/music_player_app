import 'package:core/core.dart';

part 'sign_in_state.freezed.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    @Default(Status.ready) Status status,
    @Default('') String email,
    @Default('') String password,
    String? emailError,
    String? passwordError,
    String? errorMessage,
    @Default(false) bool isValid,
  }) = _SignInState;
}
