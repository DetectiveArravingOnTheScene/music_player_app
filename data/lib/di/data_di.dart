import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data.dart';
import '../providers/api_provider.dart';
import '../providers/remote/remote_music_provider/remote_music_provider.dart';
import '../providers/remote/remote_music_provider/sound_cloud_provider.dart';

final DataDependencyInjection dataDependencyInjection =
    DataDependencyInjection();

class DataDependencyInjection {
  void initialize() {
    _initGoogleSignIn();
    _initSupabase();
    _initProviders();
    _initRepositories();
    _initServices();
    _initUseCases();
  }

  void _initGoogleSignIn() {
    final GoogleSignIn instance = GoogleSignIn.instance;
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
    serviceLocator.registerSingleton<ApiProvider>(ApiProvider());

    serviceLocator.registerSingleton<RemoteMusicProvider>(
      SoundCloudProvider(serviceLocator.get<ApiProvider>()),
    );

    serviceLocator.registerSingletonAsync<AuthProvider>(() async {
      return SupabaseAuthProvider(
        serviceLocator.get<Supabase>(),
        serviceLocator.get<GoogleSignIn>(),
      );
    }, dependsOn: <Type>[Supabase]);
  }

  void _initRepositories() {
    serviceLocator.registerSingletonWithDependencies<AuthRepository>(() {
      return AuthRepositoryImpl(serviceLocator.get<AuthProvider>());
    }, dependsOn: <Type>[AuthProvider]);
  }

  void _initServices() {
    serviceLocator.registerSingleton<UserValidatonService>(
      UserValidatonService(),
    );

    serviceLocator.registerSingletonWithDependencies<AuthService>(() {
      return AuthService(serviceLocator.get<AuthRepository>().user);
    }, dependsOn: <Type>[AuthRepository]);
  }

  void _initUseCases() {
    serviceLocator.registerSingletonWithDependencies<SignInWithEmailUseCase>(
      () {
        return SignInWithEmailUseCase(serviceLocator.get<AuthRepository>());
      },
      dependsOn: <Type>[AuthRepository],
    );
    serviceLocator.registerSingletonWithDependencies<SignUpWithEmailUseCase>(
      () {
        return SignUpWithEmailUseCase(serviceLocator.get<AuthRepository>());
      },
      dependsOn: <Type>[AuthRepository],
    );
    serviceLocator.registerSingletonWithDependencies<SignInWithGoogleUseCase>(
      () {
        return SignInWithGoogleUseCase(serviceLocator.get<AuthRepository>());
      },
      dependsOn: <Type>[AuthRepository],
    );
  }
}
