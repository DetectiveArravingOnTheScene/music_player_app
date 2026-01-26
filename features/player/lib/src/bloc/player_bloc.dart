import 'dart:async';

import 'package:domain/domain.dart';
import 'package:domain/use_cases/tracks/like_track_use_case.dart';
import 'package:domain/use_cases/tracks/remove_like_use_case.dart';
import 'package:domain/use_cases/tracks/subscribe_to_track_updates_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' as ja;

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerBlocState> {
  final PlayerService _service;
  final GetTrackStreamsUseCase _getTrackStreamsUseCase;
  final LikeTrackUseCase _likeTrackUseCase;
  final RemoveLikeTrackUseCase _removeLikeTrackUseCase;
  final SubscribeToTrackUpdatesUseCase _subscribeToTrackUpdatesUseCase;

  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<Duration>? _playerPositionSubscription;
  StreamSubscription<TrackModel>? _trackUpdatesSubscription;

  final StreamController<Duration> _positionStream =
      StreamController<Duration>.broadcast();

  Stream<Duration> get positionStream => _positionStream.stream;

  PlayerBloc({
    required PlayerService service,
    required GetTrackStreamsUseCase getTrackStreamsUseCase,
    required SubscribeToTrackUpdatesUseCase subscribeToTrackUpdatesUseCase,
    required LikeTrackUseCase likeTrack,
    required RemoveLikeTrackUseCase removeLikeTrack,
  }) : _service = service,
       _getTrackStreamsUseCase = getTrackStreamsUseCase,
       _subscribeToTrackUpdatesUseCase = subscribeToTrackUpdatesUseCase,
       _likeTrackUseCase = likeTrack,
       _removeLikeTrackUseCase = removeLikeTrack,
       super(const PlayerBlocState()) {
    on<PlayerInit>(_onInit);
    on<PlayerSetPlaylist>(_onSetPlaylist);
    on<PlayerPlay>(_onPlay);
    on<PlayerPause>(_onPause);
    on<PlayerNext>(_onNext);
    on<PlayerPrevious>(_onPrevious);
    on<PlayerToggleShuffle>(_onToggleShuffle);
    on<PlayerLikeTrack>(_onLikeTrack);
    on<TrackUpdatedEvent>(_onTrackUpdated);

    // Internal listener handler
    on<_PlayerPlaybackStateChanged>(_onPlaybackStateChanged);
  }

  void _onInit(PlayerInit event, Emitter<PlayerBlocState> emit) {
    _playerStateSubscription = _service.playbackStateStream.listen((
      ja.PlayerState state,
    ) {
      add(_PlayerPlaybackStateChanged(state));
    });
    _playerPositionSubscription = _service.positionStream.listen(
      _positionStream.add,
    );
    _trackUpdatesSubscription = _subscribeToTrackUpdatesUseCase
        .execute()
        .listen((TrackModel updated) {
          add(TrackUpdatedEvent(updated));
        });
  }

  Future<void> _onSetPlaylist(
    PlayerSetPlaylist event,
    Emitter<PlayerBlocState> emit,
  ) async {
    final List<int> indices = List<int>.generate(
      event.playlist.length,
      (int i) => i,
    );

    emit(
      state.copyWith(
        playlist: event.playlist,
        currentIndex: event.initialIndex,
        shuffleIndices: indices,
        isShuffleMode: false,
      ),
    );

    await _playCurrentTrack(emit);
  }

  Future<void> _playCurrentTrack(Emitter<PlayerBlocState> emit) async {
    final TrackModel? track = state.currentTrack;
    if (track == null) {
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final Map<StreamTypeEnum, String> streamUrls =
          await _getTrackStreamsUseCase.execute(track.urn);

      await _service.playTrack(track, streamUrls);

      emit(state.copyWith(isLoading: false, isPlaying: true));
    } catch (e) {
      // emit(state.copyWith(isLoading: false));
      // Auto-skip on error?
      add(PlayerNext());
    }
  }

  Future<void> _onNext(PlayerNext event, Emitter<PlayerBlocState> emit) async {
    if (state.playlist.isEmpty) return;

    int nextIndex = state.currentIndex + 1;

    // Handle end of playlist
    if (nextIndex >= state.playlist.length) {
      if (state.loopMode == LoopMode.all) {
        nextIndex = 0;
      } else {
        // Stop playback

        await _service.stop();
        emit(state.copyWith(isPlaying: false, currentIndex: 0));
        return;
      }
    }

    emit(state.copyWith(currentIndex: nextIndex));

    await _playCurrentTrack(emit);
  }

  Future<void> _onPrevious(
    PlayerPrevious event,
    Emitter<PlayerBlocState> emit,
  ) async {
    int prevIndex = state.currentIndex - 1;
    if (prevIndex < 0) prevIndex = 0; // or wrap if loop is on

    emit(state.copyWith(currentIndex: prevIndex));
    await _playCurrentTrack(emit);
  }

  void _onToggleShuffle(
    PlayerToggleShuffle event,
    Emitter<PlayerBlocState> emit,
  ) {
    final bool newMode = !state.isShuffleMode;
    List<int> newIndices;

    if (newMode) {
      newIndices = List<int>.generate(state.playlist.length, (int i) => i)
        ..shuffle();
    } else {
      newIndices = List<int>.generate(state.playlist.length, (int i) => i);
    }

    emit(state.copyWith(isShuffleMode: newMode, shuffleIndices: newIndices));
  }

  void _onPlaybackStateChanged(
    _PlayerPlaybackStateChanged event,
    Emitter<PlayerBlocState> emit,
  ) {
    emit(state.copyWith(isPlaying: event.state.playing));

    if (event.state.processingState == ja.ProcessingState.completed) {
      add(PlayerNext());
    }
  }

  void _onPlay(PlayerPlay event, Emitter<PlayerBlocState> emit) {
    _service.resume();

    emit(state.copyWith(isPlaying: true));
  }

  void _onPause(PlayerPause event, Emitter<PlayerBlocState> emit) {
    _service.pause();

    emit(state.copyWith(isPlaying: false));
  }

  Future<void> _onLikeTrack(
    PlayerLikeTrack event,
    Emitter<PlayerBlocState> emit,
  ) async {
    if (event.liked) {
      await _likeTrackUseCase.execute(event.track);
    } else {
      await _removeLikeTrackUseCase.execute(event.track);
    }
  }

  void _onTrackUpdated(TrackUpdatedEvent event, Emitter<PlayerBlocState> emit) {
    final int index = state.playlist.indexWhere(
      (TrackModel t) => t.urn == event.updatedTrack.urn,
    );

    if (index != -1) {
      final List<TrackModel> newPlaylist = List<TrackModel>.from(
        state.playlist,
      );
      newPlaylist[index] = event.updatedTrack;
      emit(state.copyWith(playlist: newPlaylist));
    }
  }

  @override
  Future<void> close() {
    _playerStateSubscription?.cancel();
    _playerPositionSubscription?.cancel();
    _trackUpdatesSubscription?.cancel();
    _positionStream.close();
    _service.dispose();
    return super.close();
  }
}
