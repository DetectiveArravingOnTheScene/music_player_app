abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);
  final String email;
}

class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.password);
  final String password;
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}

class SignUpWithGoogleSubmitted extends SignUpEvent {
  const SignUpWithGoogleSubmitted();
}

class SignUpConfirmPasswordChanged extends SignUpEvent {
  const SignUpConfirmPasswordChanged(this.confirmPassword);
  final String confirmPassword;
}
