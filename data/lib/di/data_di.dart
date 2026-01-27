import 'package:core/core.dart';
import 'package:domain/domain.dart';
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
    _initGoogleSignIn();
    _initIsar();
    _initSupabase();
    _initProviders();
    _initRepositories();
    _initServices();
    _initUseCases();
  }

  void _initGoogleSignIn() {
    serviceLocator.registerSingleton<GoogleSignIn>(GoogleSignIn.instance);
  }

  void _initIsar() {
    serviceLocator.registerSingletonAsync<IsarProvider>(() async {
      final IsarProvider provider = IsarProvider();
      await provider.initialize();
      return provider;
    });
  }

  void _initSupabase() {
    serviceLocator.registerSingletonAsync<Supabase>(() async {
      await Supabase.initialize(
        url: serviceLocator.get<AppConfig>().supabaseUrl,
        anonKey: serviceLocator.get<AppConfig>().supabasePublishibleKey,
      );
      return Supabase.instance;
    });
  }

  void _initProviders() {
    serviceLocator.registerSingleton<ApiProvider>(ApiProvider());

    serviceLocator.registerSingleton<RemoteMusicProvider>(
      SoundCloudProviderImpl(serviceLocator.get<ApiProvider>()),
    );

    serviceLocator.registerLazySingleton<AuthProvider>(() {
      return SupabaseAuthProvider(
        serviceLocator.get<Supabase>(),
        serviceLocator.get<GoogleSignIn>(),
      );
    });

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
      return IsarLikedArtistsTableProvider(
        serviceLocator.get<IsarProvider>().instance,
      );
    });

    serviceLocator.registerLazySingleton<LocalLikedPlaylistsTableProvider>(() {
      return IsarLikedPlaylistsTableProvider(
        serviceLocator.get<IsarProvider>().instance,
      );
    });

    serviceLocator.registerLazySingleton<LocalLikedTracksTableProvider>(() {
      return IsarLikedTracksTableProvider(
        serviceLocator.get<IsarProvider>().instance,
      );
    });

    serviceLocator.registerLazySingleton<LocalPlaylistTracksTableProvider>(() {
      return IsarPlaylistTracksTableProvider(
        serviceLocator.get<IsarProvider>().instance,
      );
    });

    serviceLocator.registerLazySingleton<LocalUserPlaylistsTableProvider>(() {
      return IsarUserPlaylistsTableProvider(
        serviceLocator.get<IsarProvider>().instance,
      );
    });

    serviceLocator.registerLazySingleton<LocalUserSettingsTableProvider>(() {
      return IsarUserSettingsTableProvider(
        serviceLocator.get<IsarProvider>().instance,
      );
    });
  }

  void _initRepositories() {
    serviceLocator.registerLazySingleton<AuthRepository>(() {
      return AuthRepositoryImpl(serviceLocator.get<AuthProvider>());
    });

    serviceLocator.registerLazySingleton<TrackRepository>(
      () {
        return TrackRepositoryImpl(
          remoteProvider: serviceLocator.get<RemoteMusicProvider>(),
          cloudProvider: serviceLocator.get<CloudLikedTracksTableProvider>(),
          localProvider: serviceLocator.get<LocalLikedTracksTableProvider>(),
        );
      },

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
    });

    serviceLocator.registerLazySingleton<PlayerService>(() {
      return PlayerService(serviceLocator.get<AuthService>());
    });
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

    serviceLocator.registerLazySingleton<GetTrackStreamsUseCase>(() {
      return GetTrackStreamsUseCase(serviceLocator.get<TrackRepository>());
    });

    serviceLocator.registerLazySingleton<SubscribeToTrackUpdatesUseCase>(() {
      return SubscribeToTrackUpdatesUseCase(
        serviceLocator.get<TrackRepository>(),
      );
    });

    serviceLocator.registerLazySingleton<LikeTrackUseCase>(() {
      return LikeTrackUseCase(serviceLocator.get<TrackRepository>());
    });

    serviceLocator.registerLazySingleton<RemoveLikeTrackUseCase>(() {
      return RemoveLikeTrackUseCase(serviceLocator.get<TrackRepository>());
    });
  }
}
