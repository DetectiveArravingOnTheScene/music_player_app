library;

import 'package:navigation/navigation.dart';

export 'src/bloc/player_bloc.dart';
export 'src/ui/player_screen.dart';
export 'src/ui/widgets/player_widget.dart';

@AutoRouterConfig()
class PlayerRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[];
}
