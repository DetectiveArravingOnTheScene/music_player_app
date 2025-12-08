import 'package:auth/src/bloc/auth_event.dart';
import 'package:auth/src/bloc/auth_state.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignInWithEmailUseCase signInWithEmailUseCase,
    required SignUpWithEmailUseCase signUpWithEmailUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
  }) : _signInWithEmailUseCase = signInWithEmailUseCase,
       _signUpWithEmailUseCase = signUpWithEmailUseCase,
       _signInWithGoogleUseCase = signInWithGoogleUseCase,
       super(
         const AuthState(
           status: Status.ready,
           email: '',
           password: '',
           emailError: null,
           passwordError: null,
         ),
       ) {
    on<AuthEmailChanged>(_onAuthEmailChanged);
    on<AuthPasswordChanged>(_onAuthPasswordChanged);
    on<SignInSubmitted>(_onSignInSubmitted);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<GoogleSignUpSubmitted>(_onGoogleSignUpSubmitted);
  }

  final SignInWithEmailUseCase _signInWithEmailUseCase;
  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  void _onAuthEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    String? error = _validateEmail(event.email);

    emit(
      state.copyWith(
        email: event.email,
        emailError: error,
        isValid: error == null ? true : false,
      ),
    );
  }

  void _onAuthPasswordChanged(
    AuthPasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    String? error = _validatePassword(event.password);

    emit(
      state.copyWith(
        password: event.password,
        passwordError: error,
        isValid: error == null ? true : false,
      ),
    );
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (state.isValid) {
      try {
        emit(state.copyWith(status: Status.loading));
        await _signUpWithEmailUseCase.execute(
          SignInWithEmailPayload(state.email, state.password),
        );
        emit(state.copyWith(status: Status.success));
      } catch (e) {
        //TODO(Roman): Add error messages
        emit(state.copyWith(status: Status.failure));
      }
    }
  }

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (state.isValid) {
      try {
        emit(state.copyWith(status: Status.loading));
        await _signInWithEmailUseCase.execute(
          SignInWithEmailPayload(state.email, state.password),
        );
        emit(state.copyWith(status: Status.success));
      } catch (e) {
        //TODO(Roman): Add error messages
        emit(state.copyWith(status: Status.failure));
      }
    }
  }

  Future<void> _onGoogleSignUpSubmitted(
    GoogleSignUpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _signInWithGoogleUseCase.execute();
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      //TODO(Roman): Add error messages
      emit(state.copyWith(status: Status.failure));
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
