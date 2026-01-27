import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/services/auth_service.dart';
import 'package:domain/services/player_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:isar_plus/isar_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data.dart';

final DataDependencyInjection dataDependencyInjection =
    DataDependencyInjection();

class DataDependencyInjection {
  void initialize() {
    _initIsar();
    _initProviders();
    _initRepositories();
    _initServices();
    _initUseCases();
  }

  void _initIsar() {
    serviceLocator.registerSingletonAsync<IsarProvider>(() async {
      final IsarProvider provider = IsarProvider();
      await provider.initialize();
      return provider;
    });
  }

  void _initProviders() {
    serviceLocator.registerSingleton<ApiProvider>(ApiProvider());

    serviceLocator.registerSingletonWithDependencies<RemoteMusicProvider>(() {
      return SoundCloudProviderImpl(serviceLocator.get<ApiProvider>());
    }, dependsOn: <Type>[ApiProvider]);

    serviceLocator.registerSingletonWithDependencies<AuthProvider>(() {
      return SupabaseAuthProvider(
        serviceLocator.get<Supabase>(),
        serviceLocator.get<GoogleSignIn>(),
      );
    }, dependsOn: <Type>[Supabase, GoogleSignIn]);

    serviceLocator.registerLazySingleton<CloudLikedTracksTableProvider>(() {
      return SupabaseLikedTracksTableProvider(
        supabase: serviceLocator.get<Supabase>(),
      );
    });

    serviceLocator.registerLazySingleton<CloudLikedPlaylistsTableProvider>(() {
      return SupabaseLikedPlaylistsTableProvider(
        supabase: serviceLocator.get<Supabase>(),
      );
    });

    serviceLocator.registerLazySingleton<CloudLikedArtistsTableProvider>(() {
      return SupabaseLikedArtistsTableProvider(
        supabase: serviceLocator.get<Supabase>(),
      );
    });

    serviceLocator.registerLazySingleton<CloudUserPlaylistsTableProvider>(() {
      return SupabaseUserPlaylistsTableProvider(
        supabase: serviceLocator.get<Supabase>(),
      );
    });

    serviceLocator.registerLazySingleton<CloudPlaylistTracksTableProvider>(() {
      return SupabasePlaylistTracksTableProvider(
        supabase: serviceLocator.get<Supabase>(),
      );
    });

    serviceLocator.registerLazySingleton<CloudUserSettingsTableProvider>(() {
      return SupabaseUserSettingsTableProvider(
        supabase: serviceLocator.get<Supabase>(),
      );
    });

    serviceLocator.registerLazySingleton<LocalLikedArtistsTableProvider>(() {
      return IsarLikedArtistsTableProvider(serviceLocator.get<Isar>());
    });

    serviceLocator.registerLazySingleton<LocalLikedPlaylistsTableProvider>(() {
      return IsarLikedPlaylistsTableProvider(serviceLocator.get<Isar>());
    });

    serviceLocator.registerLazySingleton<LocalLikedTracksTableProvider>(() {
      return IsarLikedTracksTableProvider(serviceLocator.get<Isar>());
    });

    serviceLocator.registerLazySingleton<LocalPlaylistTracksTableProvider>(() {
      return IsarPlaylistTracksTableProvider(serviceLocator.get<Isar>());
    });

    serviceLocator.registerLazySingleton<LocalUserPlaylistsTableProvider>(() {
      return IsarUserPlaylistsTableProvider(serviceLocator.get<Isar>());
    });

    serviceLocator.registerLazySingleton<LocalUserSettingsTableProvider>(() {
      return IsarUserSettingsTableProvider(serviceLocator.get<Isar>());
    });
  }

  void _initRepositories() {
    serviceLocator.registerLazySingleton<AuthRepository>(() {
      return AuthRepositoryImpl(serviceLocator.get<AuthProvider>());
    });

    serviceLocator.registerLazySingleton<TrackRepository>(() {
      return TrackRepositoryImpl(
        remoteProvider: serviceLocator.get<RemoteMusicProvider>(),
        cloudProvider: serviceLocator.get<CloudLikedTracksTableProvider>(),
        localProvider: serviceLocator.get<LocalLikedTracksTableProvider>(),
      );
    }, dispose: (TrackRepository repo) => repo.dispose());
  }

  void _initServices() {
    serviceLocator.registerLazySingleton<UserValidatonService>(
      UserValidatonService.new,
    );

    serviceLocator.registerLazySingleton<AuthService>(() {
      return AuthService(serviceLocator.get<AuthRepository>().user);
    }, dependsOn: <Type>[AuthRepository]);

    serviceLocator.registerSingletonAsync<PlayerService>(() async {
      return PlayerService(serviceLocator.get<AuthService>());
    }, dependsOn: <Type>[AuthService]);
  }

  void _initUseCases() {
    serviceLocator.registerLazySingleton<SignInWithEmailUseCase>(() {
      return SignInWithEmailUseCase(serviceLocator.get<AuthRepository>());
    });

    serviceLocator.registerLazySingleton<SignUpWithEmailUseCase>(() {
      return SignUpWithEmailUseCase(serviceLocator.get<AuthRepository>());
    });

    serviceLocator.registerLazySingleton<SignInWithGoogleUseCase>(() {
      return SignInWithGoogleUseCase(serviceLocator.get<AuthRepository>());
    });

    serviceLocator.registerLazySingleton<GetTrandingTracksUseCase>(() {
      return GetTrandingTracksUseCase(serviceLocator.get<TrackRepository>());
    });
  }
}
