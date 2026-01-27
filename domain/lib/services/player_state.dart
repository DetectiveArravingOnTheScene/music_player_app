part of 'player_service.dart';

class PlayerState {
  final bool isPlaying;
  final ProcessingState processingState;

  const PlayerState({
    required this.isPlaying,
    required this.processingState,
  });
}

enum ProcessingState {
  idle,
  loading,
  buffering,
  ready,
  completed,
}

ProcessingState _mapProcessingState(ja.ProcessingState jaState) {
  switch (jaState) {
    case ja.ProcessingState.idle:
      return ProcessingState.idle;
    case ja.ProcessingState.loading:
      return ProcessingState.loading;
    case ja.ProcessingState.buffering:
      return ProcessingState.buffering;
    case ja.ProcessingState.ready:
      return ProcessingState.ready;
    case ja.ProcessingState.completed:
      return ProcessingState.completed;
  }
}
