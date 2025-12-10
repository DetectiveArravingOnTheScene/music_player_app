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
    serviceLocator.registerSingleton<AppRouter>(AppRouter());
  }
}
