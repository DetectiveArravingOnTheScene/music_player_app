import '../../domain.dart';

class RemoveLikeTrackUseCase extends FutureUseCase<TrackModel, void> {
  final TrackRepository _trackRepository;

  RemoveLikeTrackUseCase(TrackRepository trackRepository)
    : _trackRepository = trackRepository;

  @override
  Future<void> execute(TrackModel track) {
    return _trackRepository.removeLikeTrack(track);
  }
}
