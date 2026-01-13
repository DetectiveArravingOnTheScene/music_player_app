import 'dart:async';

import 'package:domain/domain.dart';
import 'package:domain/services/player_service.dart';
import 'package:domain/use_cases/tracks/get_track_streams_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerBlocState> {
  final PlayerService _service;
  final GetTrackStreamsUseCase _getTrackStreamsUseCase;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<Duration>? _playerPositionSubscription;

  final StreamController<Duration> _positionStream =
      StreamController<Duration>.broadcast();

  Stream<Duration> get positionStream => _positionStream.stream;

  PlayerBloc({
    required PlayerService service,
    required GetTrackStreamsUseCase getTrackStreamsUseCase,
  }) : _service = service,
       _getTrackStreamsUseCase = getTrackStreamsUseCase,
       super(const PlayerBlocState()) {
    on<PlayerInit>(_onInit);
    on<PlayerSetPlaylist>(_onSetPlaylist);
    on<PlayerPlay>(_onPlay);
    on<PlayerPause>(_onPause);
    on<PlayerNext>(_onNext);
    on<PlayerPrevious>(_onPrevious);
    on<PlayerToggleShuffle>(_onToggleShuffle);

    // Internal listener handler
    on<_PlayerPlaybackStateChanged>(_onPlaybackStateChanged);
  }

  void _onInit(PlayerInit event, Emitter<PlayerBlocState> emit) {
    _playerStateSubscription = _service.playbackStateStream.listen((
      PlayerState state,
    ) {
      add(_PlayerPlaybackStateChanged(state));
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
    if (track == null) return;

    emit(state.copyWith(isLoading: true));
    try {
      final Map<StreamTypeEnum, String> streamUrls =
          await _getTrackStreamsUseCase.execute(track.urn);
      await _service.playTrack(track, streamUrls[StreamTypeEnum.httpMp3128]!);
      emit(state.copyWith(isLoading: false, isPlaying: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      // Auto-skip on error?
      add(PlayerNext());
    }
  }

  void _onNext(PlayerNext event, Emitter<PlayerBlocState> emit) {
    if (state.playlist.isEmpty) return;

    int nextIndex = state.currentIndex + 1;

    // Handle end of playlist
    if (nextIndex >= state.playlist.length) {
      if (state.loopMode == LoopMode.all) {
        nextIndex = 0;
      } else {
        // Stop playback
        _service.stop();
        emit(state.copyWith(isPlaying: false, currentIndex: 0));
        return;
      }
    }

    emit(state.copyWith(currentIndex: nextIndex));
    _playCurrentTrack(emit);
  }

  void _onPrevious(PlayerPrevious event, Emitter<PlayerBlocState> emit) {
    int prevIndex = state.currentIndex - 1;
    if (prevIndex < 0) prevIndex = 0; // or wrap if loop is on

    emit(state.copyWith(currentIndex: prevIndex));
    _playCurrentTrack(emit);
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
    emit(state.copyWith(isPlaying: event.state.isPlaying));

    if (event.state.processingState == ProcessingState.completed) {
      add(PlayerNext());
    }
  }

  void _onPlay(PlayerPlay event, Emitter<PlayerBlocState> emit) {
    _service.resume();
  }

  void _onPause(PlayerPause event, Emitter<PlayerBlocState> emit) {
    _service.pause();
  }

  @override
  Future<void> close() {
    _playerStateSubscription?.cancel();
    _service.dispose();
    return super.close();
  }
}
