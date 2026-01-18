import '../../domain.dart';

class LikeTrackUseCase extends FutureUseCase<TrackModel, void> {
  final TrackRepository _trackRepository;

  LikeTrackUseCase(
    TrackRepository trackRepository,
  ) : _trackRepository = trackRepository;

  @override
  Future<void> execute(TrackModel track) {
    return _trackRepository.likeTrack(track);
  }
}
