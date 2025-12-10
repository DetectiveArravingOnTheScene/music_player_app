import '../navigation.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthWatcher authWatcher;
  AuthGuard(this.authWatcher);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authWatcher.currentUser != null) {
      resolver.next();
    } else {
      resolver.redirectUntil(
        AuthRoute(onResult: (bool didLogin) => resolver.next(didLogin)),
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
      router.replaceAll(<PageRouteInfo<Object?>>[const HomeRoute()]);
    } else {
      resolver.next();
    }
  }
}
