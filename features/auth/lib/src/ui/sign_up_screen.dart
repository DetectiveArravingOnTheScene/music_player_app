import 'package:auth/src/bloc/blocs.dart';
import 'package:auth/src/bloc/sign_up/sign_up_event.dart';
import 'package:auth/src/bloc/sign_up/sign_up_state.dart';
import 'package:auth/src/ui/widgets/auth_scope.dart';
import 'package:auth/src/ui/widgets/auth_screen_carcass.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        signUpWithEmailUseCase: serviceLocator.get<SignUpWithEmailUseCase>(),
        signInWithGoogleUseCase: serviceLocator.get<SignInWithGoogleUseCase>(),
      ),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listenWhen: (p, c) => p.status != c.status,
        listener: (context, state) {
          if (state.status == Status.failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          if (state.status == Status.success) {
            final authScope = AuthScope.of(context);
            if (authScope?.onResult != null) {
              // SCENARIO: Deep Link / Guard Redirection
              // Trigger the guard callback to resume the original route
              authScope!.onResult!(true);
            }
          }
        },
        builder: (context, state) {
          return AuthScreenCarcass(
            title: t.login.signUp,
            textFields: [
              TextField(
                onChanged: (value) =>
                    context.read<SignUpBloc>().add(SignUpEmailChanged(value)),
                // controller: emailController,
                decoration: InputDecoration(
                  label: Text(t.login.email),
                  errorText: state.emailError,
                ),
              ),
              TextField(
                onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpPasswordChanged(value),
                ),
                // controller: passwordController,
                decoration: InputDecoration(
                  label: Text(t.login.password),
                  errorText: state.passwordError,
                ),
              ),
              TextField(
                onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpConfirmPasswordChanged(value),
                ),
                // controller: passwordController,
                decoration: InputDecoration(
                  label: Text(t.login.confirmPassword),
                  errorText: state.confirmPasswordError,
                ),
              ),
            ],
            button: Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: () {
                      context.read<SignUpBloc>().add(SignUpSubmitted());
                    },
                    child: Text(t.login.signUp),
                  ),
                ),
              ],
            ),
            authProviders: [
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        context.read<SignUpBloc>().add(
                          SignUpWithGoogleSubmitted(),
                        );
                      },
                      child: Text(t.login.google),
                    ),
                  ),
                ],
              ),
            ],
            bottomWidget: TextButton(
              onPressed: () {
                context.navigateTo(SignInRoute());
              },
              child: Text(t.login.haveAccount),
            ),
          );
        },
      ),
    );
  }
}
