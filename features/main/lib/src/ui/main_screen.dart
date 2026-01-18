import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_cases/tracks/like_track_use_case.dart';
import 'package:domain/use_cases/tracks/remove_like_use_case.dart';
import 'package:domain/use_cases/tracks/subscribe_to_track_updates_use_case.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:player/player.dart';

import 'main_content.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerBloc>(
      create: (BuildContext context) => PlayerBloc(
        service: serviceLocator.get<PlayerService>(),
        getTrackStreamsUseCase: serviceLocator.get<GetTrackStreamsUseCase>(),
        likeTrack: serviceLocator.get<LikeTrackUseCase>(),
        removeLikeTrack: serviceLocator.get<RemoveLikeTrackUseCase>(),
        subscribeToTrackUpdatesUseCase: serviceLocator
            .get<SubscribeToTrackUpdatesUseCase>(),
      )..add(PlayerInit()),
      child: const MainContent(),
    );
  }
}
