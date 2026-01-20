import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';
import 'home_content.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(
        getTrandingTracksUseCase: serviceLocator
            .get<GetTrandingTracksUseCase>(),
      )..add(const HomePageOpenedEvent()),
      child: const HomeContent(),
    );
  }
}
