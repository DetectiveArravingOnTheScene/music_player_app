import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return Container();
      },
    );
  }
}
