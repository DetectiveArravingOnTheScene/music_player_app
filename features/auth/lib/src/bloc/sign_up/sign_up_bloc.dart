import 'package:auth/src/bloc/sign_up/sign_up_event.dart';
import 'package:auth/src/bloc/sign_up/sign_up_state.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required SignUpWithEmailUseCase signUpWithEmailUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
  }) : _signUpWithEmailUseCase = signUpWithEmailUseCase,
       _signInWithGoogleUseCase = signInWithGoogleUseCase,
       super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpSubmitted>(_onSubmitted);
    on<SignUpWithGoogleSubmitted>(_onGoogleSubmitted);
  }

  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    final error = _validateEmail(event.email);
    emit(
      state.copyWith(
        email: event.email,
        emailError: error,
        isValid: _calculateIsValid(
          emailError: error,
          passwordError: state.passwordError,
          confirmPasswordError: state.confirmPasswordError,
          email: event.email,
          password: state.password,
          confirmPassword: state.confirmPassword,
        ),
      ),
    );
  }

  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final passwordError = _validatePassword(event.password);

    final confirmPasswordError = _validateConfirmPassword(
      state.confirmPassword,
      event.password,
    );

    emit(
      state.copyWith(
        password: event.password,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
        isValid: _calculateIsValid(
          emailError: state.emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          email: state.email,
          password: event.password,
          confirmPassword: state.confirmPassword,
        ),
      ),
    );
  }

  void _onConfirmPasswordChanged(
    SignUpConfirmPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final error = _validateConfirmPassword(
      event.confirmPassword,
      state.password,
    );

    emit(
      state.copyWith(
        confirmPassword: event.confirmPassword,
        confirmPasswordError: error,
        isValid: _calculateIsValid(
          emailError: state.emailError,
          passwordError: state.passwordError,
          confirmPasswordError: error,
          email: state.email,
          password: state.password,
          confirmPassword: event.confirmPassword,
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);
    final confirmPasswordError = _validateConfirmPassword(
      state.confirmPassword,
      state.password,
    );

    if (emailError == null &&
        passwordError == null &&
        confirmPasswordError == null) {
      try {
        emit(state.copyWith(status: Status.loading));
        await _signUpWithEmailUseCase.execute(
          SignInWithEmailPayload(state.email, state.password),
        );
        emit(state.copyWith(status: Status.success));
      } on AppException catch (e) {
        emit(state.copyWith(status: Status.failure, errorMessage: e.message));
      }
    } else {
      emit(
        state.copyWith(
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          isValid: false,
        ),
      );
    }
  }

  Future<void> _onGoogleSubmitted(
    SignUpWithGoogleSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _signInWithGoogleUseCase.execute();
      emit(state.copyWith(status: Status.success));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.message));
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
    if (value.isEmpty) {
      return t.login.emailError.empty;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return t.login.emailError.invalid;
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return t.login.passwordError.empty;
    }

    if (value.length < 8) {
      return t.login.passwordError.short;
    }

    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return t.login.passwordError.noUppercase;
    }

    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return t.login.passwordError.noNumber;
    }

    // Check for at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return t.login.passwordError.noSpecial;
    }

    return null;
  }

  String? _validateConfirmPassword(
    String? confirmValue,
    String originalPassword,
  ) {
    if (confirmValue == null || confirmValue.isEmpty) {
      return t.login.confirmPasswordError.empty;
    }
    if (confirmValue != originalPassword) {
      return t.login.confirmPasswordError.mismatch;
    }
    return null;
  }
}
