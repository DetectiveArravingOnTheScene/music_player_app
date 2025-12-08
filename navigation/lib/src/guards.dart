import 'package:navigation/navigation.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthWatcher authWatcher;
  AuthGuard(this.authWatcher);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authWatcher.currentUser != null) {
      resolver.next();
    } else {
      resolver.redirectUntil(
        AuthRoute(onResult: (didLogin) => resolver.next(didLogin)),
      );
    }
  }
}

class GuestGuard extends AutoRouteGuard {
  final AuthWatcher authWatcher;
  GuestGuard(this.authWatcher);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authWatcher.currentUser != null) {
      resolver.next(false);
      router.replaceAll([HomeRoute()]);
    } else {
      resolver.next();
    }
  }
}
