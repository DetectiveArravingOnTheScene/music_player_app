import 'package:auth/src/bloc/auth_bloc.dart';
import 'package:auth/src/bloc/auth_event.dart';
import 'package:auth/src/bloc/auth_state.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({required this.onResult, super.key});

  final void Function(bool) onResult;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        signInWithEmailUseCase: serviceLocator.get<SignInWithEmailUseCase>(),
        signInWithGoogleUseCase: serviceLocator.get<SignInWithGoogleUseCase>(),
        signUpWithEmailUseCase: serviceLocator.get<SignUpWithEmailUseCase>(),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoRouter(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(),
                  ),
                  Text("or continue with"),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FilledButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                GoogleSignUpSubmitted(),
                              );
                            },
                            child: Text("Google"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
