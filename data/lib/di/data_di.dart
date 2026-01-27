import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/services/auth_service.dart';
import 'package:domain/use_cases/tracks/like_track_use_case.dart';
import 'package:domain/use_cases/tracks/remove_like_use_case.dart';
import 'package:domain/use_cases/tracks/subscribe_to_track_updates_use_case.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        return IsarLikedArtistsTableProvider(
          serviceLocator.get<IsarProvider>().instance,
        );
      },
      dependsOn: <Type>[IsarProvider],
    );

    serviceLocator.registerSingletonAsync<LocalLikedPlaylistsTableProvider>(
      () async {
        return IsarLikedPlaylistsTableProvider(
          serviceLocator.get<IsarProvider>().instance,
        );
      },
      dependsOn: <Type>[IsarProvider],
    );

    serviceLocator.registerSingletonAsync<LocalLikedTracksTableProvider>(
      () async {
        return IsarLikedTracksTableProvider(
          serviceLocator.get<IsarProvider>().instance,
        );
      },
      dependsOn: <Type>[IsarProvider],
    );

    serviceLocator.registerSingletonAsync<LocalPlaylistTracksTableProvider>(
      () async {
        return IsarPlaylistTracksTableProvider(
          serviceLocator.get<IsarProvider>().instance,
        );
      },
      dependsOn: <Type>[IsarProvider],
    );

    serviceLocator.registerSingletonAsync<LocalUserPlaylistsTableProvider>(
      () async {
        return IsarUserPlaylistsTableProvider(
          serviceLocator.get<IsarProvider>().instance,
        );
      },
      dependsOn: <Type>[IsarProvider],
    );

    serviceLocator.registerSingletonAsync<LocalUserSettingsTableProvider>(
      () async {
        return IsarUserSettingsTableProvider(
          serviceLocator.get<IsarProvider>().instance,
        );
      },
      dependsOn: <Type>[IsarProvider],
    );
  }

  void _initRepositories() {
    serviceLocator.registerLazySingleton<AuthRepository>(() {
      return AuthRepositoryImpl(serviceLocator.get<AuthProvider>());
    });

    serviceLocator.registerSingletonWithDependencies<TrackRepository>(
      () {
        return TrackRepositoryImpl(
          remoteProvider: serviceLocator.get<RemoteMusicProvider>(),
          cloudProvider: serviceLocator.get<CloudLikedTracksTableProvider>(),
          localProvider: serviceLocator.get<LocalLikedTracksTableProvider>(),
        );
      },
      dependsOn: <Type>[
        RemoteMusicProvider,
        CloudLikedTracksTableProvider,
        LocalLikedTracksTableProvider,
      ],
      dispose: (TrackRepository repo) {
        repo.dispose();
      },
    );
  }

  void _initServices() {
    serviceLocator.registerLazySingleton<UserValidatonService>(
      UserValidatonService.new,
    );

    serviceLocator.registerLazySingleton<AuthService>(() {
      return AuthService(serviceLocator.get<AuthRepository>().user);
    }, dependsOn: <Type>[AuthRepository]);

    serviceLocator.registerSingleton<PlayerService>(PlayerService());
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

    serviceLocator.registerSingletonWithDependencies<GetTrackStreamsUseCase>(
      () {
        return GetTrackStreamsUseCase(serviceLocator.get<TrackRepository>());
      },
      dependsOn: <Type>[TrackRepository],
    );

    serviceLocator
        .registerSingletonWithDependencies<SubscribeToTrackUpdatesUseCase>(() {
          return SubscribeToTrackUpdatesUseCase(
            serviceLocator.get<TrackRepository>(),
          );
        }, dependsOn: <Type>[TrackRepository]);

    serviceLocator.registerSingletonWithDependencies<LikeTrackUseCase>(() {
      return LikeTrackUseCase(serviceLocator.get<TrackRepository>());
    }, dependsOn: <Type>[TrackRepository]);

    serviceLocator.registerSingletonWithDependencies<RemoveLikeTrackUseCase>(
      () {
        return RemoveLikeTrackUseCase(serviceLocator.get<TrackRepository>());
      },
      dependsOn: <Type>[TrackRepository],
    );
  }
}
