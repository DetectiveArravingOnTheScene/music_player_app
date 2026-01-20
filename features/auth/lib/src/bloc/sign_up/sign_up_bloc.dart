import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final UserValidatonService _userValidatonService;

  SignUpBloc({
    required SignUpWithEmailUseCase signUpWithEmailUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required UserValidatonService userValidationService,
  }) : _signUpWithEmailUseCase = signUpWithEmailUseCase,
       _signInWithGoogleUseCase = signInWithGoogleUseCase,
       _userValidatonService = userValidationService,
       super(const SignUpState.input()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpSubmitted>(_onSubmitted);
    on<SignUpWithGoogleSubmitted>(_onGoogleSubmitted);
  }

  ({String email, String password, String confirmPassword})? get _formData {
    return switch (state) {
      InputSignUp(
        :final String email,
        :final String password,
        :final String confirmPassword,
      ) ||
      SubmittingSignUp(
        :final String email,
        :final String password,
        :final String confirmPassword,
      ) ||
      FailureSignUp(
        :final String email,
        :final String password,
        :final String confirmPassword,
      ) => (email: email, password: password, confirmPassword: confirmPassword),
      _ => null,
    };
  }

  String? get _currentEmailError => switch (state) {
    InputSignUp(:final String? emailError) ||
    FailureSignUp(:final String? emailError) => emailError,
    _ => null,
  };

  String? get _currentPasswordError => switch (state) {
    InputSignUp(:final String? passwordError) ||
    FailureSignUp(:final String? passwordError) => passwordError,
    _ => null,
  };

  String? get _currentConfirmPasswordError => switch (state) {
    InputSignUp(:final String? confirmPasswordError) ||
    FailureSignUp(:final String? confirmPasswordError) => confirmPasswordError,
    _ => null,
  };

  bool get _currentIsValid => switch (state) {
    InputSignUp(:final bool isValid) ||
    FailureSignUp(:final bool isValid) => isValid,
    _ => false,
  };

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    final ({String confirmPassword, String email, String password})? data =
        _formData;
    if (data == null) return;

    final String? error = _validateEmail(event.email);

    emit(
      SignUpState.input(
        email: event.email,
        password: data.password,
        confirmPassword: data.confirmPassword,
        emailError: error,
        passwordError: _currentPasswordError,
        confirmPasswordError: _currentConfirmPasswordError,
        isValid: _calculateIsValid(
          emailError: error,
          passwordError: _currentPasswordError,
          confirmPasswordError: _currentConfirmPasswordError,
          email: event.email,
          password: data.password,
          confirmPassword: data.confirmPassword,
        ),
      ),
    );
  }

  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final ({String confirmPassword, String email, String password})? data =
        _formData;
    if (data == null) return;

    final String? passwordError = _validatePassword(event.password);
    final String? confirmPasswordError = _validateConfirmPassword(
      data.confirmPassword,
      event.password,
    );

    emit(
      SignUpState.input(
        email: data.email,
        password: event.password,
        confirmPassword: data.confirmPassword,
        emailError: _currentEmailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
        isValid: _calculateIsValid(
          emailError: _currentEmailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          email: data.email,
          password: event.password,
          confirmPassword: data.confirmPassword,
        ),
      ),
    );
  }

  void _onConfirmPasswordChanged(
    SignUpConfirmPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final ({String confirmPassword, String email, String password})? data =
        _formData;
    if (data == null) return;

    final String? error = _validateConfirmPassword(
      event.confirmPassword,
      data.password,
    );

    emit(
      SignUpState.input(
        email: data.email,
        password: data.password,
        confirmPassword: event.confirmPassword,
        emailError: _currentEmailError,
        passwordError: _currentPasswordError,
        confirmPasswordError: error,
        isValid: _calculateIsValid(
          emailError: _currentEmailError,
          passwordError: _currentPasswordError,
          confirmPasswordError: error,
          email: data.email,
          password: data.password,
          confirmPassword: event.confirmPassword,
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    final ({String confirmPassword, String email, String password})? data =
        _formData;
    if (data == null) return;

    final String? emailError = _validateEmail(data.email);
    final String? passwordError = _validatePassword(data.password);
    final String? confirmPasswordError = _validateConfirmPassword(
      data.confirmPassword,
      data.password,
    );

    final bool isValid =
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;

    if (isValid) {
      try {
        emit(
          SignUpState.submitting(
            email: data.email,
            password: data.password,
            confirmPassword: data.confirmPassword,
          ),
        );

        await _signUpWithEmailUseCase.execute(
          SignInWithEmailPayload(data.email, data.password),
        );

        emit(const SignUpState.success());
      } on AppException catch (e) {
        emit(
          SignUpState.failure(
            errorMessage: e.message,
            email: data.email,
            password: data.password,
            confirmPassword: data.confirmPassword,
            emailError: emailError,
            passwordError: passwordError,
            confirmPasswordError: confirmPasswordError,
          ),
        );
      }
    } else {
      emit(
        SignUpState.input(
          email: data.email,
          password: data.password,
          confirmPassword: data.confirmPassword,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
        ),
      );
    }
  }

  Future<void> _onGoogleSubmitted(
    SignUpWithGoogleSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    final ({String confirmPassword, String email, String password})? data =
        _formData;

    final String currentEmail = data?.email ?? '';
    final String currentPass = data?.password ?? '';
    final String currentConfirm = data?.confirmPassword ?? '';

    try {
      emit(
        SignUpState.submitting(
          email: currentEmail,
          password: currentPass,
          confirmPassword: currentConfirm,
        ),
      );

      await _signInWithGoogleUseCase.execute();

      emit(const SignUpState.success());
    } on AppException catch (e) {
      emit(
        SignUpState.failure(
          errorMessage: e.message,
          email: currentEmail,
          password: currentPass,
          confirmPassword: currentConfirm,
          isValid: _currentIsValid,
        ),
      );
    }
  }

  bool _calculateIsValid({
    required String? emailError,
    required String? passwordError,
    required String? confirmPasswordError,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;
  }

  String? _validateEmail(String value) {
    return _userValidatonService.validateEmail(value);
  }

  String? _validatePassword(String value) {
    return _userValidatonService.validatePassword(value);
  }

  String? _validateConfirmPassword(
    String? confirmValue,
    String originalPassword,
  ) {
    return _userValidatonService.validateConfirmPassword(
      confirmValue,
      originalPassword,
    );
  }
}
