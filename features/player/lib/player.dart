library;

import 'package:navigation/navigation.dart';

export 'src/bloc/player_bloc.dart';
export 'src/ui/player_screen.dart';

@AutoRouterConfig()
class PlayerRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[];
}
