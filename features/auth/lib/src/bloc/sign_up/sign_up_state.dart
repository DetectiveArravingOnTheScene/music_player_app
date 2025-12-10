import 'package:core/core.dart';

part 'sign_up_state.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(SignUpStatus.ready) SignUpStatus status,
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? errorMessage,
    @Default(false) bool isValid,
  }) = _SignUpState;
}

enum SignUpStatus { loading, ready, success, failure }
