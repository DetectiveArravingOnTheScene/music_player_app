import 'package:auth/src/bloc/auth_bloc.dart';
import 'package:auth/src/bloc/auth_event.dart';
import 'package:auth/src/bloc/auth_state.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            spacing: 24,
            children: [
              TextField(
                onChanged: (value) =>
                    context.read<AuthBloc>().add(AuthEmailChanged(value)),
                // controller: emailController,
                decoration: InputDecoration(
                  label: Text("Email"),
                  errorText: state.emailError,
                ),
              ),
              TextField(
                onChanged: (value) =>
                    context.read<AuthBloc>().add(AuthPasswordChanged(value)),
                // controller: passwordController,
                decoration: InputDecoration(
                  label: Text("Password"),
                  errorText: state.passwordError,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignInSubmitted());
                      },
                      child: Text("Sign in"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
