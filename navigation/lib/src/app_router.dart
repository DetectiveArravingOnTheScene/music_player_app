import 'package:navigation/navigation.dart';

class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: MainRoute.page),
    AutoRoute(
      page: MainRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: UserCollectionRoute.page),
      ],
    ),
    AutoRoute(page: PlayerRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    AutoRouteGuard.simple((resolver, router) {
      if (false || resolver.routeName == AuthRoute.name) {
        // we continue navigation
        resolver.next();
      } else {
        resolver.redirectUntil(
          AuthRoute(onResult: (didLogin) => resolver.next(didLogin)),
        );
      }
    }),
  ];
}
