part of 'player_bloc.dart';

enum LoopMode { off, all, one }

class PlayerBlocState {
  final List<TrackModel> playlist;
  final int currentIndex;
  final bool isShuffleMode;
  final LoopMode loopMode;
  final List<int> shuffleIndices;

  final bool isPlaying;
  final bool isLoading;

  final bool isError;
  final String errorMessage;

  TrackModel? get currentTrack {
    if (playlist.isEmpty) return null;
    final int index = isShuffleMode
        ? shuffleIndices[currentIndex]
        : currentIndex;
    return playlist[index];
  }

  TrackModel? get prevTrack {
    if (playlist.isEmpty) return null;
    if (currentIndex == 0) return null;

    final int index = isShuffleMode
        ? shuffleIndices[currentIndex - 1]
        : currentIndex - 1;

    return playlist[index];
  }

  TrackModel? get nextTrack {
    if (playlist.isEmpty) return null;
    if (currentIndex == playlist.length - 1) return null;

    final int index = isShuffleMode
        ? shuffleIndices[currentIndex + 1]
        : currentIndex + 1;

    return playlist[index];
  }

  const PlayerBlocState({
    this.playlist = const <TrackModel>[],
    this.currentIndex = 0,
    this.isShuffleMode = false,
    this.loopMode = LoopMode.off,
    this.shuffleIndices = const <int>[],
    this.isPlaying = false,
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
  });

  PlayerBlocState copyWith({
    List<TrackModel>? playlist,
    int? currentIndex,
    bool? isShuffleMode,
    LoopMode? loopMode,
    List<int>? shuffleIndices,
    bool? isPlaying,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  }) {
    return PlayerBlocState(
      playlist: playlist ?? this.playlist,
      currentIndex: currentIndex ?? this.currentIndex,
      isShuffleMode: isShuffleMode ?? this.isShuffleMode,
      loopMode: loopMode ?? this.loopMode,
      shuffleIndices: shuffleIndices ?? this.shuffleIndices,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
