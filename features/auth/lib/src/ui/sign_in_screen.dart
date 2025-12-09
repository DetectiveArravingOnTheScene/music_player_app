import 'package:auth/src/bloc/blocs.dart';
import 'package:auth/src/bloc/sign_In/sign_in_event.dart';
import 'package:auth/src/bloc/sign_In/sign_in_state.dart';
import 'package:auth/src/ui/widgets/auth_scope.dart';
import 'package:auth/src/ui/widgets/auth_screen_carcass.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
        signInWithEmailUseCase: serviceLocator.get<SignInWithEmailUseCase>(),
        signInWithGoogleUseCase: serviceLocator.get<SignInWithGoogleUseCase>(),
      ),
      child: BlocConsumer<SignInBloc, SignInState>(
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
            title: t.login.signIn,
            textFields: [
              TextField(
                onChanged: (value) =>
                    context.read<SignInBloc>().add(SignInEmailChanged(value)),
                decoration: InputDecoration(
                  label: Text(t.login.email),
                  errorText: state.emailError,
                ),
              ),
              TextField(
                onChanged: (value) => context.read<SignInBloc>().add(
                  SignInPasswordChanged(value),
                ),
                obscureText: true,
                decoration: InputDecoration(
                  label: Text(t.login.password),
                  errorText: state.passwordError,
                ),
              ),
            ],
            button: Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: () {
                      context.read<SignInBloc>().add(SignInSubmitted());
                    },
                    child: Text(t.login.signIn),
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
                        context.read<SignInBloc>().add(
                          SignInWithGoogleSubmitted(),
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
                context.navigateTo(SignUpRoute());
              },
              child: Text(t.login.haveNoAccount),
            ),
          );
        },
      ),
    );
  }
}
