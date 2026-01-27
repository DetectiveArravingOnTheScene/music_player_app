import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'widgets/auth_scope.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({this.onResult, super.key});

  final void Function({required bool didLogin})? onResult;

  @override
  Widget build(BuildContext context) {
    return AuthScope(
      onResult: onResult,
      child: const Scaffold(body: SafeArea(child: AutoRouter())),
    );
  }
}
