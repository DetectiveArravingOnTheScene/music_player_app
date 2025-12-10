import 'package:core/core.dart';
import '../navigation.dart';
import 'guards.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(
      page: AuthRoute.page,
      path: '/auth',
      guards: <AutoRouteGuard>[GuestGuard(serviceLocator.get<AuthWatcher>())],
      children: <AutoRoute>[
        AutoRoute(page: SignInRoute.page, path: 'signin', initial: true),
        AutoRoute(page: SignUpRoute.page, path: 'signup'),
      ],
    ),
    AutoRoute(
      page: MainRoute.page,
      path: '/',
      guards: <AutoRouteGuard>[AuthGuard(serviceLocator.get<AuthWatcher>())],
      children: <AutoRoute>[
        AutoRoute(page: HomeRoute.page, initial: true, path: 'home'),
        AutoRoute(page: SearchRoute.page, path: 'search'),
        AutoRoute(page: UserCollectionRoute.page, path: 'collection'),
        AutoRoute(page: PlayerRoute.page, path: 'player'),
      ],
    ),
  ];
}
