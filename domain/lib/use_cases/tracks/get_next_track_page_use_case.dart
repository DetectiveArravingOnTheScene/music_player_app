import '../../domain.dart';

class GetNextTracksPageUseCase
    extends FutureUseCase<String, CollectionModel<TrackModel>> {
  final TrackRepository _repository;

  GetNextTracksPageUseCase(this._repository);

  @override
  Future<CollectionModel<TrackModel>> execute(String trackUrn) async {
    return _repository.getNextPage(trackUrn);
  }
}
