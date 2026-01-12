import 'package:core/core.dart';
import 'package:domain/domain.dart';

import 'home_event.dart';
import 'home_state.dart';
export 'home_event.dart';
export 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTrandingTracksUseCase _getTrandingTracksUseCase;

  HomeBloc({required GetTrandingTracksUseCase getTrandingTracksUseCase})
    : _getTrandingTracksUseCase = getTrandingTracksUseCase,
      super(const HomeState.loading()) {
    on<HomePageOpenedEvent>(_onHomePageOpened);
  }

  Future<void> _onHomePageOpened(
    HomePageOpenedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());
    try {
      final CollectionModel<TrackModel> tracks = await _getTrandingTracksUseCase
          .execute();
      emit(HomeState.success(trandingTracks: tracks));
    } on AppException catch (e) {
      emit(HomeState.failure(errorMessage: e.message));
    } catch (_) {
      emit(HomeState.failure(errorMessage: t.error.generalError));
    }
  }
}
