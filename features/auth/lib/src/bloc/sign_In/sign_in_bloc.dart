import 'package:core/core.dart';
import 'package:domain/domain.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

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
    final String? error = _validateEmail(event.email);
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
    final String? error = _validatePassword(event.password);
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
    final String? emailError = _validateEmail(state.email);
    final String? passwordError = _validatePassword(state.password);

    if (emailError == null && passwordError == null) {
      try {
        emit(state.copyWith(status: SignInStatus.loading));
        await _signInWithEmailUseCase.execute(
          SignInWithEmailPayload(state.email, state.password),
        );
        emit(state.copyWith(status: SignInStatus.success));
      } on AppException catch (e) {
        emit(
          state.copyWith(status: SignInStatus.failure, errorMessage: e.message),
        );
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
      emit(state.copyWith(status: SignInStatus.loading));
      await _signInWithGoogleUseCase.execute();
      emit(state.copyWith(status: SignInStatus.success));
    } on AppException catch (e) {
      emit(
        state.copyWith(status: SignInStatus.failure, errorMessage: e.message),
      );
    }
  }

  String? _validateEmail(String value) {
    return serviceLocator.get<UserValidatonService>().validateEmail(value);
  }

  String? _validatePassword(String value) {
    return serviceLocator.get<UserValidatonService>().validatePassword(value);
  }
}
