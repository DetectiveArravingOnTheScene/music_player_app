import 'package:core/core.dart';
import 'package:domain/domain.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInWithEmailUseCase _signInWithEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final UserValidatonService _userValidatonService;

  SignInBloc({
    required SignInWithEmailUseCase signInWithEmailUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required UserValidatonService userValidationService,
  }) : _signInWithEmailUseCase = signInWithEmailUseCase,
       _signInWithGoogleUseCase = signInWithGoogleUseCase,
       _userValidatonService = userValidationService,
       super(const SignInState.input()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSubmitted);
    on<SignInWithGoogleSubmitted>(_onGoogleSubmitted);
  }

  String _getCurrentEmail() {
    return switch (state) {
      InputSignIn(:final String email) ||
      SubmittingSignIn(:final String email) ||
      FailureSignIn(:final String email) => email,
      _ => '',
    };
  }

  String _getCurrentPassword() {
    return switch (state) {
      InputSignIn(:final String password) ||
      SubmittingSignIn(:final String password) ||
      FailureSignIn(:final String password) => password,
      _ => '',
    };
  }

  void _onEmailChanged(SignInEmailChanged event, Emitter<SignInState> emit) {
    final String email = event.email;
    final String password = _getCurrentPassword();

    final String? emailError = _validateEmail(email);
    final String? passwordError = _validatePassword(password);

    emit(
      SignInState.input(
        email: email,
        password: password,
        emailError: emailError,
        passwordError: passwordError,
        isValid:
            emailError == null &&
            passwordError == null &&
            email.isNotEmpty &&
            password.isNotEmpty,
      ),
    );
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    final String email = _getCurrentEmail();
    final String password = event.password;

    final String? passwordError = _validatePassword(password);
    final String? emailError = _validateEmail(email);

    emit(
      SignInState.input(
        email: email,
        password: password,
        emailError: emailError,
        passwordError: passwordError,
        isValid:
            emailError == null &&
            passwordError == null &&
            email.isNotEmpty &&
            password.isNotEmpty,
      ),
    );
  }

  Future<void> _onSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    final String email = _getCurrentEmail();
    final String password = _getCurrentPassword();

    final String? emailError = _validateEmail(email);
    final String? passwordError = _validatePassword(password);

    if (emailError == null && passwordError == null) {
      try {
        emit(SignInState.submitting(email: email, password: password));

        await _signInWithEmailUseCase.execute(
          SignInWithEmailPayload(email, password),
        );

        emit(const SignInState.success());
      } on AppException catch (e) {
        emit(
          SignInState.failure(
            email: email,
            password: password,
            errorMessage: e.message,
          ),
        );
      }
    } else {
      emit(
        SignInState.input(
          email: email,
          password: password,
          emailError: emailError,
          passwordError: passwordError,
        ),
      );
    }
  }

  Future<void> _onGoogleSubmitted(
    SignInWithGoogleSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    final String email = _getCurrentEmail();
    final String password = _getCurrentPassword();

    try {
      emit(SignInState.submitting(email: email, password: password));
      await _signInWithGoogleUseCase.execute();

      emit(const SignInState.success());
    } on AppException catch (e) {
      emit(
        SignInState.failure(
          email: email,
          password: password,
          errorMessage: e.message,
        ),
      );
    }
  }

  String? _validateEmail(String value) {
    return _userValidatonService.validateEmail(value);
  }

  String? _validatePassword(String value) {
    return _userValidatonService.validatePassword(value);
  }
}
