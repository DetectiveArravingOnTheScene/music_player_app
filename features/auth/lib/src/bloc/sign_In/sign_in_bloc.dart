import 'package:auth/src/bloc/sign_In/sign_in_event.dart';
import 'package:auth/src/bloc/sign_In/sign_in_state.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required SignInWithEmailUseCase signInWithEmailUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
  }) : _signInWithEmailUseCase = signInWithEmailUseCase,
       _signInWithGoogleUseCase = signInWithGoogleUseCase,
       super(const SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSubmitted);
    on<SignInWithGoogleSubmitted>(_onGoogleSubmitted);
  }

  final SignInWithEmailUseCase _signInWithEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  void _onEmailChanged(SignInEmailChanged event, Emitter<SignInState> emit) {
    final error = _validateEmail(event.email);
    emit(
      state.copyWith(
        email: event.email,
        emailError: error,
        isValid:
            error == null &&
            state.passwordError == null &&
            state.password.isNotEmpty,
      ),
    );
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    final error = _validatePassword(event.password);
    emit(
      state.copyWith(
        password: event.password,
        passwordError: error,
        isValid:
            error == null && state.emailError == null && state.email.isNotEmpty,
      ),
    );
  }

  Future<void> _onSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);

    if (emailError == null && passwordError == null) {
      try {
        emit(state.copyWith(status: Status.loading));
        await _signInWithEmailUseCase.execute(
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
          isValid: false,
        ),
      );
    }
  }

  Future<void> _onGoogleSubmitted(
    SignInWithGoogleSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _signInWithGoogleUseCase.execute();
      emit(state.copyWith(status: Status.success));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.message));
    }
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
}
