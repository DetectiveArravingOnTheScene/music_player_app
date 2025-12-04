import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({required this.onResult, super.key});

  final void Function(bool) onResult;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
