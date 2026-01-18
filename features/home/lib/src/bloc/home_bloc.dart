import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_cases/tracks/like_track_use_case.dart';
import 'package:domain/use_cases/tracks/remove_like_use_case.dart';
import 'package:domain/use_cases/tracks/subscribe_to_track_updates_use_case.dart';

import 'home_event.dart';
import 'home_state.dart';
export 'home_event.dart';
export 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTrandingTracksUseCase _getTrandingTracksUseCase;
  final SubscribeToTrackUpdatesUseCase _subscribeToTrackUpdatesUseCase;
  final LikeTrackUseCase _likeTrackUseCase;
  final RemoveLikeTrackUseCase _removeLikeTrackUseCase;

  StreamSubscription<TrackModel>? _trackUpdatesSubscription;

  HomeBloc({
    required GetTrandingTracksUseCase getTrandingTracksUseCase,
    required SubscribeToTrackUpdatesUseCase subscribeToTrackUpdatesUseCase,
    required LikeTrackUseCase likeTrack,
    required RemoveLikeTrackUseCase removeLikeTrack,
  }) : _getTrandingTracksUseCase = getTrandingTracksUseCase,
       _subscribeToTrackUpdatesUseCase = subscribeToTrackUpdatesUseCase,
       _likeTrackUseCase = likeTrack,
       _removeLikeTrackUseCase = removeLikeTrack,
       super(const HomeState.loading()) {
    on<HomePageOpenedEvent>(_onHomePageOpened);
    on<TrackUpdatedEvent>(_onTrackUpdated);
    on<HomeLikeTrack>(_onLikeTrack);
  }

  Future<void> _onHomePageOpened(
    HomePageOpenedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());
    try {
      final CollectionModel<TrackModel> tracks = await _getTrandingTracksUseCase
          .execute();

      _trackUpdatesSubscription = _subscribeToTrackUpdatesUseCase
          .execute()
          .listen((TrackModel updated) => add(TrackUpdatedEvent(updated)));
      emit(HomeState.success(trandingTracks: tracks));
    } on AppException catch (e) {
      emit(HomeState.failure(errorMessage: e.message));
    } catch (_) {
      emit(HomeState.failure(errorMessage: t.error.generalError));
    }
  }

  void _onTrackUpdated(TrackUpdatedEvent event, Emitter<HomeState> emit) {
    state.mapOrNull(
      // ignore: always_specify_types
      success: (state) {
        final List<TrackModel> currentTracks = state.trandingTracks.items;

        final int index = currentTracks.indexWhere(
          (TrackModel t) => t.urn == event.updatedTrack.urn,
        );

        if (index != -1) {
          final List<TrackModel> newTracks = List<TrackModel>.from(
            currentTracks,
          );
          newTracks[index] = event.updatedTrack;

          emit(
            state.copyWith(
              trandingTracks: state.trandingTracks.copyWith(
                items: newTracks,
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _onLikeTrack(
    HomeLikeTrack event,
    Emitter<HomeState> emit,
  ) async {
    print("ON LIKE RECEIVED");
    if (event.liked) {
      await _likeTrackUseCase.execute(event.track);
    } else {
      await _removeLikeTrackUseCase.execute(event.track);
    }
  }

  @override
  Future<void> close() {
    _trackUpdatesSubscription?.cancel();

    return super.close();
  }
}
