import 'package:core/core.dart';

class UserValidatonService {
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return t.login.emailError.empty;
    }

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return t.login.emailError.invalid;
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return t.login.passwordError.empty;
    }

    if (value.length < 8) {
      return t.login.passwordError.short;
    }

    if (!value.contains(RegExp('[A-Z]'))) {
      return t.login.passwordError.noUppercase;
    }

    if (!value.contains(RegExp('[0-9]'))) {
      return t.login.passwordError.noNumber;
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return t.login.passwordError.noSpecial;
    }

    return null;
  }

  String? validateConfirmPassword(
    String? confirmValue,
    String originalPassword,
  ) {
    if (confirmValue == null || confirmValue.isEmpty) {
      return t.login.confirmPasswordError.empty;
    }
    if (confirmValue != originalPassword) {
      return t.login.confirmPasswordError.mismatch;
    }
    return null;
  }
}
