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
  final Duration position; // Optional: usually keep separate stream for UI perf

  TrackModel? get currentTrack {
    if (playlist.isEmpty) return null;
    final int index = isShuffleMode
        ? shuffleIndices[currentIndex]
        : currentIndex;
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
    this.position = Duration.zero,
  });

  PlayerBlocState copyWith({
    List<TrackModel>? playlist,
    int? currentIndex,
    bool? isShuffleMode,
    LoopMode? loopMode,
    List<int>? shuffleIndices,
    bool? isPlaying,
    bool? isLoading,
  }) {
    return PlayerBlocState(
      playlist: playlist ?? this.playlist,
      currentIndex: currentIndex ?? this.currentIndex,
      isShuffleMode: isShuffleMode ?? this.isShuffleMode,
      loopMode: loopMode ?? this.loopMode,
      shuffleIndices: shuffleIndices ?? this.shuffleIndices,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
