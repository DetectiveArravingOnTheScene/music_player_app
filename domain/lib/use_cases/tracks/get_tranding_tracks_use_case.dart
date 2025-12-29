import '../../domain.dart';
import '../../models/music_models/collection_model.dart';

class GetTrandingTracksUseCase
    extends FutureUseCaseNoParams<CollectionModel<TrackModel>> {
  final TrackRepository _trackRepository;

  GetTrandingTracksUseCase(TrackRepository trackRepository)
    : _trackRepository = trackRepository;

  @override
  Future<CollectionModel<TrackModel>> execute() async {
    return _trackRepository.getTrendingTracks();
  }
}
