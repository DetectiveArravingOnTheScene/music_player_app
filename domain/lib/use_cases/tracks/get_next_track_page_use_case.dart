import '../../domain.dart';

class GetNextTracksPageUseCase {
  final TrackRepository _repository;

  GetNextTracksPageUseCase(this._repository);

  Future<CollectionModel<TrackModel>> execute(String nextUrl) {
    return _repository.getNextPage(nextUrl);
  }
}
