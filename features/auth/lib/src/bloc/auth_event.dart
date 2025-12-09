import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthEmailChanged extends AuthEvent {
  const AuthEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class AuthPasswordChanged extends AuthEvent {
  const AuthPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class SignInSubmitted extends AuthEvent {
  const SignInSubmitted();
}

final class SignUpSubmitted extends AuthEvent {
  const SignUpSubmitted();
}

final class GoogleSignUpSubmitted extends AuthEvent {
  const GoogleSignUpSubmitted();
}

final class SignUpPageRequested extends AuthEvent {
  const SignUpPageRequested();
}

final class SignInPageRequested extends AuthEvent {
  const SignInPageRequested();
}
