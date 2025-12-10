import 'package:flutter/widgets.dart';

class AuthScope extends InheritedWidget {
  const AuthScope({super.key, required this.onResult, required super.child});

  final void Function({bool didLogin})? onResult;

  static AuthScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthScope>();
  }

  @override
  bool updateShouldNotify(AuthScope oldWidget) {
    return onResult != oldWidget.onResult;
  }
}
