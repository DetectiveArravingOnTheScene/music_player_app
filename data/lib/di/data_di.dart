import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final DataDependencyInjection dataDependencyInjection =
    DataDependencyInjection();

class DataDependencyInjection {
  void initialize() {
    _initGoogleSignIn();
    _initSupabase();
    _initProviders();
    _initRepositories();
    _initUseCases();
  }

  void _initGoogleSignIn() {
    GoogleSignIn instance = GoogleSignIn.instance;
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

  void _initProviders() {
    serviceLocator.registerSingletonAsync<AuthProvider>(() async {
      return SupabaseAuthProvider(
        serviceLocator.get<Supabase>(),
        serviceLocator.get<GoogleSignIn>(),
      );
    }, dependsOn: [Supabase]);
  }

  void _initRepositories() {
    serviceLocator.registerSingletonWithDependencies<AuthRepository>(() {
      return AuthRepositoryImpl(serviceLocator.get<AuthProvider>());
    }, dependsOn: [AuthProvider]);
  }

  void _initUseCases() {
    serviceLocator.registerSingletonWithDependencies<SignInWithEmailUseCase>(
      () {
        return SignInWithEmailUseCase(serviceLocator.get<AuthRepository>());
      },
      dependsOn: [AuthRepository],
    );
    serviceLocator.registerSingletonWithDependencies<SignUpWithEmailUseCase>(
      () {
        return SignUpWithEmailUseCase(serviceLocator.get<AuthRepository>());
      },
      dependsOn: [AuthRepository],
    );
    serviceLocator.registerSingletonWithDependencies<SignInWithGoogleUseCase>(
      () {
        return SignInWithGoogleUseCase(serviceLocator.get<AuthRepository>());
      },
      dependsOn: [AuthRepository],
    );
  }
}
