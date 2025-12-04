import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final DataDependencyInjection dataDependencyInjection =
    DataDependencyInjection();

class DataDependencyInjection {
  void initialize() {
    _initGoogleSignIn();
    _initSupabase();
    _initAuthProvider();
  }

  void _initGoogleSignIn() {
    var instance = GoogleSignIn.instance;
    instance.initialize(
      serverClientId: GoogleSignInOptions.webClientId,
      clientId: GoogleSignInOptions.iosClientId,
    );
    serviceLocator.registerSingleton<GoogleSignIn>(instance);
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
    serviceLocator.registerSingletonAsync<IAuthProvider>(() async {
      return SupabaseAuthProvider(
        serviceLocator.get<Supabase>(),
        serviceLocator.get<GoogleSignIn>(),
      );
    }, dependsOn: [Supabase]);
  }
}
