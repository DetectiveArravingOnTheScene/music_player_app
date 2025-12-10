import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/blocs.dart';
import 'widgets/auth_scope.dart';
import 'widgets/auth_screen_template.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (BuildContext context) => SignInBloc(
        signInWithEmailUseCase: serviceLocator.get<SignInWithEmailUseCase>(),
        signInWithGoogleUseCase: serviceLocator.get<SignInWithGoogleUseCase>(),
      ),
      child: BlocConsumer<SignInBloc, SignInState>(
        listenWhen: (SignInState p, SignInState c) => p.status != c.status,
        listener: (BuildContext context, SignInState state) {
          if (state.status == SignInStatus.failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          if (state.status == SignInStatus.success) {
            final AuthScope? authScope = AuthScope.of(context);
            if (authScope?.onResult != null) {
              // SCENARIO: Deep Link / Guard Redirection
              // Trigger the guard callback to resume the original route
              authScope!.onResult!(didLogin: true);
            }
          }
        },
        builder: (BuildContext context, SignInState state) {
          return AuthScreenTemplate(
            title: t.login.signIn,
            textFields: <Widget>[
              TextField(
                onChanged: (String value) =>
                    context.read<SignInBloc>().add(SignInEmailChanged(value)),
                decoration: InputDecoration(
                  label: Text(t.login.email),
                  errorText: state.emailError,
                ),
              ),
              TextField(
                onChanged: (String value) => context.read<SignInBloc>().add(
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
              children: <Widget>[
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: () {
                      context.read<SignInBloc>().add(const SignInSubmitted());
                    },
                    child: Text(t.login.signIn),
                  ),
                ),
              ],
            ),
            authProviders: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        context.read<SignInBloc>().add(
                          const SignInWithGoogleSubmitted(),
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
                context.navigateTo(const SignUpRoute());
              },
              child: Text(t.login.haveNoAccount),
            ),
          );
        },
      ),
    );
  }
}
