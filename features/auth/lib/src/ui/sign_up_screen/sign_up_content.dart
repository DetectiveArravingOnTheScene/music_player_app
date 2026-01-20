import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../../auth.gr.dart';
import '../../bloc/blocs.dart';
import '../widgets/auth_scope.dart';
import '../widgets/auth_screen_template.dart';

class SignUpContent extends StatelessWidget {
  const SignUpContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (BuildContext context, SignUpState state) {
        state.mapOrNull(
          failure: (FailureSignUp state) {
            context.showErrorSnackbar(state.errorMessage);
          },
          success: (_) {
            AuthScope.of(context)!.redirectBack(redirect: true);
          },
        );
      },
      builder: (BuildContext context, SignUpState state) {
        final String? emailError = state.mapOrNull(
          input: (InputSignUp s) => s.emailError,
          failure: (FailureSignUp s) => s.emailError,
        );

        final String? passwordError = state.mapOrNull(
          input: (InputSignUp s) => s.passwordError,
          failure: (FailureSignUp s) => s.passwordError,
        );

        final String? confirmPasswordError = state.mapOrNull(
          input: (InputSignUp s) => s.confirmPasswordError,
          failure: (FailureSignUp s) => s.confirmPasswordError,
        );

        final bool isSubmitting = state.maybeMap(
          submitting: (_) => true,
          orElse: () => false,
        );

        return AuthScreenTemplate(
          title: t.login.signUp,
          textFields: <Widget>[
            TextField(
              onChanged: (String value) {
                context.read<SignUpBloc>().add(SignUpEmailChanged(value));
              },
              decoration: InputDecoration(
                label: Text(t.login.email),
                errorText: emailError,
                enabled: !isSubmitting,
              ),
            ),
            TextField(
              obscureText: true,
              onChanged: (String value) {
                context.read<SignUpBloc>().add(SignUpPasswordChanged(value));
              },
              decoration: InputDecoration(
                label: Text(t.login.password),
                errorText: passwordError,
                enabled: !isSubmitting,
              ),
            ),
            TextField(
              obscureText: true,
              onChanged: (String value) {
                context.read<SignUpBloc>().add(
                  SignUpConfirmPasswordChanged(value),
                );
              },
              decoration: InputDecoration(
                label: Text(t.login.confirmPassword),
                errorText: confirmPasswordError,
                enabled: !isSubmitting,
              ),
            ),
          ],
          button: Row(
            children: <Widget>[
              Expanded(
                child: FilledButton.tonal(
                  onPressed: isSubmitting
                      ? null
                      : () {
                          context.read<SignUpBloc>().add(
                            const SignUpSubmitted(),
                          );
                        },
                  child: isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(t.login.signUp),
                ),
              ),
            ],
          ),
          authProviders: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: FilledButton(
                    onPressed: isSubmitting
                        ? null
                        : () {
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
            onPressed: isSubmitting
                ? null
                : () {
                    context.navigateTo(const SignInRoute());
                  },
            child: Text(t.login.haveAccount),
          ),
        );
      },
    );
  }
}
