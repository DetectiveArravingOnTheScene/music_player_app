import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../../auth.gr.dart';
import '../../bloc/blocs.dart';
import '../widgets/auth_scope.dart';
import '../widgets/auth_screen_template.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (BuildContext context, SignInState state) {
        state.mapOrNull(
          failure: (state) {
            context.showErrorSnackbar(state.errorMessage);
          },
          success: (_) {
            AuthScope.of(context)!.redirectBack(redirect: true);
          },
        );
      },
      builder: (BuildContext context, SignInState state) {
        final bool isLoading = state.maybeMap(
          submitting: (_) => true,
          orElse: () => false,
        );

        final String? emailError = state.maybeMap(
          input: (s) => s.emailError,
          orElse: () => null,
        );

        final String? passwordError = state.maybeMap(
          input: (s) => s.passwordError,
          orElse: () => null,
        );

        final bool isInputValid = state.maybeMap(
          input: (s) => s.isValid,
          orElse: () => true, // Allow submit attempts in other states
        );

        return AuthScreenTemplate(
          title: t.login.signIn,
          textFields: <Widget>[
            TextField(
              enabled: !isLoading,
              onChanged: (String value) {
                context.read<SignInBloc>().add(SignInEmailChanged(value));
              },
              decoration: InputDecoration(
                label: Text(t.login.email),
                errorText: emailError,
              ),
            ),
            TextField(
              enabled: !isLoading,
              onChanged: (String value) {
                context.read<SignInBloc>().add(SignInPasswordChanged(value));
              },
              obscureText: true,
              decoration: InputDecoration(
                label: Text(t.login.password),
                errorText: passwordError,
              ),
            ),
          ],
          button: Row(
            children: <Widget>[
              Expanded(
                child: FilledButton.tonal(
                  onPressed: (isLoading || !isInputValid)
                      ? null
                      : () {
                          context.read<SignInBloc>().add(
                            const SignInSubmitted(),
                          );
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(t.login.signIn),
                ),
              ),
            ],
          ),
          authProviders: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: FilledButton(
                    onPressed: isLoading
                        ? null
                        : () {
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
            onPressed: isLoading
                ? null
                : () {
                    context.navigateTo(const SignUpRoute());
                  },
            child: Text(t.login.haveNoAccount),
          ),
        );
      },
    );
  }
}
