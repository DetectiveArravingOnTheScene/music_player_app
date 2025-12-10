import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/blocs.dart';
import 'widgets/auth_scope.dart';
import 'widgets/auth_screen_template.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (BuildContext context) => SignUpBloc(
        signUpWithEmailUseCase: serviceLocator.get<SignUpWithEmailUseCase>(),
        signInWithGoogleUseCase: serviceLocator.get<SignInWithGoogleUseCase>(),
      ),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listenWhen: (SignUpState p, SignUpState c) => p.status != c.status,
        listener: (BuildContext context, SignUpState state) {
          if (state.status == SignUpStatus.failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          if (state.status == SignUpStatus.success) {
            final AuthScope? authScope = AuthScope.of(context);
            if (authScope?.onResult != null) {
              // SCENARIO: Deep Link / Guard Redirection
              // Trigger the guard callback to resume the original route
              authScope!.onResult!(didLogin: true);
            }
          }
        },
        builder: (BuildContext context, SignUpState state) {
          return AuthScreenTemplate(
            title: t.login.signUp,
            textFields: <Widget>[
              TextField(
                onChanged: (String value) =>
                    context.read<SignUpBloc>().add(SignUpEmailChanged(value)),
                // controller: emailController,
                decoration: InputDecoration(
                  label: Text(t.login.email),
                  errorText: state.emailError,
                ),
              ),
              TextField(
                obscureText: true,
                onChanged: (String value) => context.read<SignUpBloc>().add(
                  SignUpPasswordChanged(value),
                ),
                // controller: passwordController,
                decoration: InputDecoration(
                  label: Text(t.login.password),
                  errorText: state.passwordError,
                ),
              ),
              TextField(
                obscureText: true,
                onChanged: (String value) => context.read<SignUpBloc>().add(
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
              children: <Widget>[
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: () {
                      context.read<SignUpBloc>().add(const SignUpSubmitted());
                    },
                    child: Text(t.login.signUp),
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
                        context.read<SignUpBloc>().add(
                          const SignUpWithGoogleSubmitted(),
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
                context.navigateTo(const SignInRoute());
              },
              child: Text(t.login.haveAccount),
            ),
          );
        },
      ),
    );
  }
}
