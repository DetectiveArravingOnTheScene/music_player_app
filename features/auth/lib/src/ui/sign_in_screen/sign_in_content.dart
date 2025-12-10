import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../../bloc/blocs.dart';
import '../widgets/auth_scope.dart';
import '../widgets/auth_screen_template.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listenWhen: (SignInState previous, SignInState current) {
        return previous.status != current.status;
      },
      listener: (BuildContext context, SignInState state) {
        if (state.status == SignInStatus.failure) {
          context.showErrorSnackbar(state.errorMessage);
        }
        if (state.status == SignInStatus.success) {
          AuthScope.of(context)!.redirectBack(redirect: true);
        }
      },
      builder: (BuildContext context, SignInState state) {
        return AuthScreenTemplate(
          title: t.login.signIn,
          textFields: <Widget>[
            TextField(
              onChanged: (String value) {
                context.read<SignInBloc>().add(
                  SignInEmailChanged(value),
                );
              },
              decoration: InputDecoration(
                label: Text(t.login.email),
                errorText: state.emailError,
              ),
            ),
            TextField(
              onChanged: (String value) {
                context.read<SignInBloc>().add(
                  SignInPasswordChanged(value),
                );
              },
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
    );
  }
}
