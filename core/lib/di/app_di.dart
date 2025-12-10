import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation/navigation.dart';

final GetIt serviceLocator = GetIt.instance;
final CoreDependencyInjection coreDependencyInjection =
    CoreDependencyInjection();

class CoreDependencyInjection {
  void initialize() {
    _initAppRouter();
  }

  void _initAppRouter() {
    serviceLocator.registerSingletonWithDependencies<AuthWatcher>(() {
      return AuthWatcher(serviceLocator.get<AuthRepository>().user);
    }, dependsOn: <Type>[AuthRepository]);
    serviceLocator.registerSingleton<AppRouter>(AppRouter());
  }
}
