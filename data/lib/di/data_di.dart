import 'package:core/core.dart';
import 'package:domain/domain.dart';
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

    serviceLocator.registerSingletonAsync<RemoteMusicProvider>(() async {
      return SoundCloudProviderImpl(serviceLocator.get<ApiProvider>());
    });

    serviceLocator.registerSingletonAsync<AuthProvider>(() async {
      return SupabaseAuthProvider(
        serviceLocator.get<Supabase>(),
        serviceLocator.get<GoogleSignIn>(),
      );
    }, dependsOn: <Type>[Supabase]);

    serviceLocator.registerSingletonAsync<CloudLikedTracksTableProvider>(
      () async {
        return SupabaseLikedTracksTableProvider(
          supabase: serviceLocator.get<Supabase>(),
        );
      },
      dependsOn: <Type>[Supabase],
    );

    serviceLocator.registerSingletonAsync<CloudLikedPlaylistsTableProvider>(
      () async {
        return SupabaseLikedPlaylistsTableProvider(
          supabase: serviceLocator.get<Supabase>(),
        );
      },
      dependsOn: <Type>[Supabase],
    );

    serviceLocator.registerSingletonAsync<CloudLikedArtistsTableProvider>(
      () async {
        return SupabaseLikedArtistsTableProvider(
          supabase: serviceLocator.get<Supabase>(),
        );
      },
      dependsOn: <Type>[Supabase],
    );

    serviceLocator.registerSingletonAsync<CloudUserPlaylistsTableProvider>(
      () async {
        return SupabaseUserPlaylistsTableProvider(
          supabase: serviceLocator.get<Supabase>(),
        );
      },
      dependsOn: <Type>[Supabase],
    );

    serviceLocator.registerSingletonAsync<CloudPlaylistTracksTableProvider>(
      () async {
        return SupabasePlaylistTracksTableProvider(
          supabase: serviceLocator.get<Supabase>(),
        );
      },
      dependsOn: <Type>[Supabase],
    );

    serviceLocator.registerSingletonAsync<CloudUserSettingsTableProvider>(
      () async {
        return SupabaseUserSettingsTableProvider(
          supabase: serviceLocator.get<Supabase>(),
        );
      },
      dependsOn: <Type>[Supabase],
    );
    serviceLocator.registerSingletonAsync<LocalLikedArtistsTableProvider>(
      () async {
        return IsarLikedArtistsTableProvider(serviceLocator.get<Isar>());
      },
      dependsOn: <Type>[Isar],
    );

    serviceLocator.registerSingletonAsync<LocalLikedPlaylistsTableProvider>(
      () async {
        return IsarLikedPlaylistsTableProvider(serviceLocator.get<Isar>());
      },
      dependsOn: <Type>[Isar],
    );

    serviceLocator.registerSingletonAsync<LocalLikedTracksTableProvider>(
      () async {
        return IsarLikedTracksTableProvider(serviceLocator.get<Isar>());
      },
      dependsOn: <Type>[Isar],
    );

    serviceLocator.registerSingletonAsync<LocalPlaylistTracksTableProvider>(
      () async {
        return IsarPlaylistTracksTableProvider(serviceLocator.get<Isar>());
      },
      dependsOn: <Type>[Isar],
    );

    serviceLocator.registerSingletonAsync<LocalUserPlaylistsTableProvider>(
      () async {
        return IsarUserPlaylistsTableProvider(serviceLocator.get<Isar>());
      },
      dependsOn: <Type>[Isar],
    );

    serviceLocator.registerSingletonAsync<LocalUserSettingsTableProvider>(
      () async {
        return IsarUserSettingsTableProvider(serviceLocator.get<Isar>());
      },
      dependsOn: <Type>[Isar],
    );
  }

  void _initRepositories() {
    serviceLocator.registerSingletonWithDependencies<AuthRepository>(() {
      return AuthRepositoryImpl(serviceLocator.get<AuthProvider>());
    }, dependsOn: <Type>[AuthProvider]);

    serviceLocator.registerSingletonWithDependencies<TrackRepository>(
      () {
        return TrackRepositoryImpl(
          remoteProvider: serviceLocator.get<RemoteMusicProvider>(),
          cloudProvider: serviceLocator.get<CloudLikedTracksTableProvider>(),
          localProvider: serviceLocator.get<LocalLikedTracksTableProvider>(),
        );
      },
      dependsOn: <Type>[RemoteMusicProvider, CloudLikedTracksTableProvider],
      dispose: (TrackRepository repo) {
        repo.dispose();
      },
    );
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

    serviceLocator.registerSingletonWithDependencies<GetTrandingTracksUseCase>(
      () {
        return GetTrandingTracksUseCase(serviceLocator.get<TrackRepository>());
      },
      dependsOn: <Type>[TrackRepository],
    );
  }
}
