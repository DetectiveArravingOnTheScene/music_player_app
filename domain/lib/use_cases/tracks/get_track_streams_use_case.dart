import '../../domain.dart';

class GetTrackStreamsUseCase
    extends FutureUseCase<String, Map<StreamTypeEnum, String>> {
  final TrackRepository _trackRepository;

  GetTrackStreamsUseCase(TrackRepository trackRepository)
    : _trackRepository = trackRepository;

  @override
  Future<Map<StreamTypeEnum, String>> execute(String streamUrl) {
    return _trackRepository.getTrackStream(streamUrl);
  }
}
