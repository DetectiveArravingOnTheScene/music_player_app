import 'package:core/core.dart';
import 'package:domain/domain.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTrandingTracksUseCase _getTrandingTracksUseCase;

  HomeBloc({required GetTrandingTracksUseCase getTrandingTracksUseCase})
    : _getTrandingTracksUseCase = getTrandingTracksUseCase,
      super(HomeState());
}
