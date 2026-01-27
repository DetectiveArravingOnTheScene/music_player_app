import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../bloc/blocs.dart';
import 'sign_up_content.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (BuildContext context) => SignUpBloc(
        signUpWithEmailUseCase: serviceLocator.get<SignUpWithEmailUseCase>(),
        signInWithGoogleUseCase: serviceLocator.get<SignInWithGoogleUseCase>(),
        userValidationService: serviceLocator.get<UserValidatonService>(),
      ),
      child: const SignUpContent(),
    );
  }
}
