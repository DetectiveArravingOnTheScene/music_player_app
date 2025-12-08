import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:navigation/src/guards.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AuthRoute.page,
      path: '/auth',
      guards: [GuestGuard(serviceLocator.get<AuthWatcher>())],
      children: [
        AutoRoute(page: SignInRoute.page, path: 'signin', initial: true),
        AutoRoute(page: SignUpRoute.page, path: 'signup'),
      ],
    ),
    AutoRoute(
      page: MainRoute.page,
      path: '/',
      guards: [AuthGuard(serviceLocator.get<AuthWatcher>())],
      children: [
        AutoRoute(page: HomeRoute.page, initial: true, path: 'home'),
        AutoRoute(page: SearchRoute.page, path: 'search'),
        AutoRoute(page: UserCollectionRoute.page, path: 'collection'),
        AutoRoute(page: PlayerRoute.page, path: 'player'),
      ],
    ),
  ];
}
