import '../../domain.dart';

class RemoveLikeTrackUseCase extends FutureUseCase<TrackModel, void> {
  final TrackRepository _trackRepository;

  RemoveLikeTrackUseCase(TrackRepository trackRepository)
    : _trackRepository = trackRepository;

  @override
  Future<void> execute(TrackModel trackUrn) {
    return _trackRepository.removeLikeTrack(trackUrn);
  }
}
