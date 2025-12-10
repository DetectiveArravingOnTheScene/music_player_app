import 'dart:async';

import 'package:flutter/material.dart';

import '../domain.dart';

class AuthService extends ChangeNotifier {
  UserModel? _currentUser;
  late final StreamSubscription<UserModel?> _subscription;

  UserModel? get currentUser => _currentUser;

  bool isInitialized = false;

  AuthService(Stream<UserModel?> authStream) {
    _subscription = authStream.listen((UserModel? user) {
      _currentUser = user;
      isInitialized = true;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
