import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:data/providers/remote/auth_provider/supabase_auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final DataDependencyInjection dataDependencyInjection =
    DataDependencyInjection();

class DataDependencyInjection {
  void initialize() {
    _initSupabase();
    _initAuthProvider();
  }

  void _initSupabase() {
    serviceLocator.registerSingletonAsync<Supabase>(() async {
      return Supabase.initialize(
        url: SupabaseOptions.projectUrl,
        anonKey: SupabaseOptions.publishibleKey,
      );
    });
  }

  void _initAuthProvider() {
    serviceLocator.registerSingletonAsync<AuthProvider>(() async {
      return SupabaseAuthProvider(supa: serviceLocator.get<Supabase>());
    }, dependsOn: [Supabase]);
  }
}
