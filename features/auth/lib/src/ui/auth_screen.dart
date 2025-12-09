import 'package:auth/src/ui/widgets/auth_scope.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({this.onResult, super.key});

  final void Function(bool)? onResult;

  @override
  Widget build(BuildContext context) {
    return AuthScope(
      onResult: onResult,
      child: Scaffold(body: SafeArea(child: AutoRouter())),
    );
  }
}
