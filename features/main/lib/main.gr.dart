// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:main/src/ui/main_screen.dart' as _i1;
import 'package:main/src/ui/main_wrapper_page.dart' as _i2;

/// generated route for
/// [_i1.MainScreen]
class MainRoute extends _i3.PageRouteInfo<void> {
  const MainRoute({List<_i3.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.MainScreen();
    },
  );
}

/// generated route for
/// [_i2.MainWrapperPage]
class MainWrapperRoute extends _i3.PageRouteInfo<void> {
  const MainWrapperRoute({List<_i3.PageRouteInfo>? children})
    : super(MainWrapperRoute.name, initialChildren: children);

  static const String name = 'MainWrapperRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.MainWrapperPage();
    },
  );
}
