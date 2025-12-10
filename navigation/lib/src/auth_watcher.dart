import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class AuthWatcher extends ChangeNotifier {
  UserModel? _currentUser;
  late final StreamSubscription<UserModel?> _subscription;

  UserModel? get currentUser => _currentUser;

  bool isInitialized = false;

  AuthWatcher(Stream<UserModel?> authStream) {
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
