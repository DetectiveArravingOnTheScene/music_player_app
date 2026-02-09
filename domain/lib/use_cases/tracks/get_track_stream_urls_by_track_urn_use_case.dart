import '../../domain.dart';

class GetTrackStreamUrlsByTrackUrnUseCase
    extends FutureUseCase<String, Map<StreamTypeEnum, String>> {
  final TrackRepository _trackRepository;

  GetTrackStreamUrlsByTrackUrnUseCase(TrackRepository trackRepository)
    : _trackRepository = trackRepository;

  @override
  Future<Map<StreamTypeEnum, String>> execute(String trackUrn) {
    return _trackRepository.getTrackStream(trackUrn);
  }
}
