import 'package:core/core.dart';
import 'package:domain/domain.dart';
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
      ),
      child: const MainContent(),
    );
  }
}
