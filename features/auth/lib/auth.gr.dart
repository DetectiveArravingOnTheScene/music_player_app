// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth/src/ui/auth_screen.dart' as _i1;
import 'package:auth/src/ui/sign_in_screen.dart' as _i2;
import 'package:auth/src/ui/sign_up_screen.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i4.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    void Function(bool)? onResult,
    _i5.Key? key,
    List<_i4.PageRouteInfo>? children,
  }) : super(
         AuthRoute.name,
         args: AuthRouteArgs(onResult: onResult, key: key),
         initialChildren: children,
       );

  static const String name = 'AuthRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthRouteArgs>(
        orElse: () => const AuthRouteArgs(),
      );
      return _i1.AuthScreen(onResult: args.onResult, key: args.key);
    },
  );
}

class AuthRouteArgs {
  const AuthRouteArgs({this.onResult, this.key});

  final void Function(bool)? onResult;

  final _i5.Key? key;

  @override
  String toString() {
    return 'AuthRouteArgs{onResult: $onResult, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AuthRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i2.SignInScreen]
class SignInRoute extends _i4.PageRouteInfo<void> {
  const SignInRoute({List<_i4.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.SignInScreen();
    },
  );
}

/// generated route for
/// [_i3.SignUpScreen]
class SignUpRoute extends _i4.PageRouteInfo<void> {
  const SignUpRoute({List<_i4.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SignUpScreen();
    },
  );
}
