import 'package:core/di/app_di.dart';
import 'package:domain/services/auth_service.dart';

import '../navigation.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (serviceLocator.get<AuthService>().currentUser != null) {
      resolver.next();
    } else {
      resolver.redirectUntil(
        AuthRoute(
          onResult: ({required bool didLogin}) => resolver.next(didLogin),
        ),
      );
    }
  }
}

class GuestGuard extends AutoRouteGuard {
  GuestGuard();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (serviceLocator.get<AuthService>().currentUser != null) {
      resolver.next(false);
      router.replaceAll(<PageRouteInfo<Object?>>[const HomeRoute()]);
    } else {
      resolver.next();
    }
  }
}
