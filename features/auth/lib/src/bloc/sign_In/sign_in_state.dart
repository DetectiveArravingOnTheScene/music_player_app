import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState.input({
    @Default('') String email,
    @Default('') String password,
    String? emailError,
    String? passwordError,
    @Default(false) bool isValid,
  }) = InputSignIn;

  const factory SignInState.submitting({
    required String email,
    required String password,
  }) = SubmittingSignIn;

  const factory SignInState.success() = SuccessSignIn;

  const factory SignInState.failure({
    required String email,
    required String password,
    required String errorMessage,
  }) = FailureSignIn;
}
