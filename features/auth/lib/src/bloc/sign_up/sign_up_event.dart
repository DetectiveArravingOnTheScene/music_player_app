import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => <Object?>[];
}

class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);
  final String email;
  @override
  List<Object> get props => <Object>[email];
}

class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.password);
  final String password;
  @override
  List<Object> get props => <Object>[password];
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
  @override
  List<Object> get props => <Object>[confirmPassword];
}
