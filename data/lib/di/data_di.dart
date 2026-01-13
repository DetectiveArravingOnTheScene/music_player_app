import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:isar_plus/isar_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data.dart';
import '../providers/api_provider.dart';
import '../providers/local/isar_provider.dart';
import '../providers/local/local_database_tables_providers/liked_artists_table/isar_liked_artist_table_provider.dart';
import '../providers/local/local_database_tables_providers/liked_artists_table/local_liked_artist_table_provider.dart';
import '../providers/local/local_database_tables_providers/liked_playlists_table/isar_liked_playlist_table_provider.dart';
import '../providers/local/local_database_tables_providers/liked_playlists_table/local_liked_playlist_table_provider.dart';
import '../providers/local/local_database_tables_providers/liked_tracks_table/isar_liked_playlist_table_provider.dart';
import '../providers/local/local_database_tables_providers/liked_tracks_table/local_liked_tracks_table_provider.dart';
import '../providers/local/local_database_tables_providers/playlist_track_table/isar_playlist_track_table_provider.dart';
import '../providers/local/local_database_tables_providers/playlist_track_table/local_playlist_track_table_provider.dart';
import '../providers/local/local_database_tables_providers/user_playlist_table/isar_user_playlist_table_provider.dart';
import '../providers/local/local_database_tables_providers/user_playlist_table/local_user_playlist_table_provider.dart';
import '../providers/local/local_database_tables_providers/user_settings_table/isar_user_settings_table_provider.dart';
import '../providers/local/local_database_tables_providers/user_settings_table/local_user_settings_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/liked_artists_table/cloud_liked_artists_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/liked_artists_table/supabase_liked_artists_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/liked_playlists_table/cloud_liked_playlists_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/liked_playlists_table/supabase_liked_playlists_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/liked_tracks_table/cloud_liked_tracks_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/liked_tracks_table/supabase_liked_tracks_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/playlist_track_table/cloud_playlist_track_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/playlist_track_table/supabase_playlist_track_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/user_playlist_table/cloud_user_playlists_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/user_playlist_table/supabase_user_playlists_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/user_settings_table/cloud_user_settings_table_provider.dart';
import '../providers/remote/cloud_database_tables_providers/user_settings_table/supabase_user_settings_table_provider.dart';
import '../providers/remote/remote_music_provider/remote_music_provider.dart';
import '../providers/remote/remote_music_provider/sound_cloud_provider_impl.dart';
import '../repositories/track_repository_impl.dart';

final DataDependencyInjection dataDependencyInjection =
    DataDependencyInjection();

class DataDependencyInjection {
  void initialize() {
    _initGoogleSignIn();
    _initSupabase();
    _initIsar();
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
<<<<<<< HEAD
=======

    serviceLocator.registerSingletonAsync<PlayerService>(() async {
      return PlayerService(serviceLocator.get<AuthService>());
    }, dependsOn: <Type>[AuthService]);
>>>>>>> 9810003 ([5.1] Update PlayerService)
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
