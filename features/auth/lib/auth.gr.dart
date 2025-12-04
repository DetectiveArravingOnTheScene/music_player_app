// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth/src/ui/auth_screen.dart' as _i1;
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i2.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    required void Function(bool) onResult,
    _i3.Key? key,
    List<_i2.PageRouteInfo>? children,
  }) : super(
         AuthRoute.name,
         args: AuthRouteArgs(onResult: onResult, key: key),
         initialChildren: children,
       );

  static const String name = 'AuthRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthRouteArgs>();
      return _i1.AuthScreen(onResult: args.onResult, key: args.key);
    },
  );
}

class AuthRouteArgs {
  const AuthRouteArgs({required this.onResult, this.key});

  final void Function(bool) onResult;

  final _i3.Key? key;

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
