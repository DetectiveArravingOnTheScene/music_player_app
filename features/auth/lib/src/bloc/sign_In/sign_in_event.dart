abstract class SignInEvent {
  const SignInEvent();
}

class SignInEmailChanged extends SignInEvent {
  const SignInEmailChanged(this.email);
  final String email;
}

class SignInPasswordChanged extends SignInEvent {
  const SignInPasswordChanged(this.password);
  final String password;
}

class SignInSubmitted extends SignInEvent {
  const SignInSubmitted();
}

class SignInWithGoogleSubmitted extends SignInEvent {
  const SignInWithGoogleSubmitted();
}
