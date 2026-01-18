import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_cases/tracks/like_track_use_case.dart';
import 'package:domain/use_cases/tracks/remove_like_use_case.dart';
import 'package:domain/use_cases/tracks/subscribe_to_track_updates_use_case.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/home_bloc.dart';
import 'home_content.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(
        likeTrack: serviceLocator.get<LikeTrackUseCase>(),
        removeLikeTrack: serviceLocator.get<RemoveLikeTrackUseCase>(),
        getTrandingTracksUseCase: serviceLocator
            .get<GetTrandingTracksUseCase>(),
        subscribeToTrackUpdatesUseCase: serviceLocator
            .get<SubscribeToTrackUpdatesUseCase>(),
      )..add(const HomePageOpenedEvent()),
      child: const HomeContent(),
    );
  }
}
