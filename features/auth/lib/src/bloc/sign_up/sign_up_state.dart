import 'package:core/core.dart';

part 'sign_up_state.freezed.dart';

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState.input({
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    @Default(false) bool isValid,
  }) = InputSignUp;

  const factory SignUpState.submitting({
    required String email,
    required String password,
    required String confirmPassword,
  }) = SubmittingSignUp;

  const factory SignUpState.success() = SuccessSignUp;

  const factory SignUpState.failure({
    required String errorMessage,
    required String email,
    required String password,
    required String confirmPassword,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    @Default(false) bool isValid,
  }) = FailureSignUp;
}
