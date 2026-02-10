import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'player_state.freezed.dart';

enum LoopMode { off, all, one }

@Freezed()
abstract class PlayerBlocState with _$PlayerBlocState {
  const PlayerBlocState._();

  const factory PlayerBlocState({
    @Default(<TrackModel>[]) List<TrackModel> playlist,
    @Default(0) int currentIndex,
    @Default(false) bool isShuffleMode,
    @Default(LoopMode.off) LoopMode loopMode,
    @Default(<int>[]) List<int> shuffleIndices,
    @Default(false) bool isPlaying,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default('') String errorMessage,
  }) = _PlayerBlocState;

  bool get isLoop => loopMode == .all || loopMode == .one;

  TrackModel? get currentTrack {
    if (playlist.isEmpty) return null;
    final int index = isShuffleMode
        ? shuffleIndices[currentIndex]
        : currentIndex;

    if (index < 0 || index >= playlist.length) return null;

    return playlist[index];
  }

  TrackModel? get prevTrack {
    if (playlist.isEmpty) return null;
    if (currentIndex == 0) return null;

    final int index = isShuffleMode
        ? shuffleIndices[currentIndex - 1]
        : currentIndex - 1;

    if (index < 0 || index >= playlist.length) return null;

    return playlist[index];
  }

  TrackModel? get nextTrack {
    if (playlist.isEmpty) return null;
    if (currentIndex == playlist.length - 1) return null;

    final int index = isShuffleMode
        ? shuffleIndices[currentIndex + 1]
        : currentIndex + 1;

    if (index < 0 || index >= playlist.length) return null;

    return playlist[index];
  }
}
