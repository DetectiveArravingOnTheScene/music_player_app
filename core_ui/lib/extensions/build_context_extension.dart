import 'package:core/core.dart';
import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showErrorSnackbar(String? message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: message != null ? Text(message) : Text(t.error.generalError),
      ),
    );
  }

  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }
}
