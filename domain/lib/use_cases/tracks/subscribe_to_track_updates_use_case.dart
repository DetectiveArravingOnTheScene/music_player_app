import '../../domain.dart';

class SubscribeToTrackUpdatesUseCase
    extends UseCaseNoParams<Stream<TrackModel>> {
  final TrackRepository _trackRepository;
  SubscribeToTrackUpdatesUseCase(TrackRepository trackRepository)
    : _trackRepository = trackRepository;

  @override
  Stream<TrackModel> execute() {
    return _trackRepository.trackUpdates;
  }
}
