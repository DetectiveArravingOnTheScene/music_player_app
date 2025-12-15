import '../../domain.dart';

class GetTrandingTracksUseCase extends FutureUseCaseNoParams<List<TrackModel>> {
  final TrackRepository _trackRepository;

  GetTrandingTracksUseCase(TrackRepository trackRepository)
    : _trackRepository = trackRepository;

  @override
  Future<List<TrackModel>> execute() async {
    // 1. Define "Recent" as the last 30 days
    const List<String> genres = <String>['Pop', 'R&B', 'Hip-hop', 'Electronic'];
    const int limit = 50;
    final DateTime now = DateTime.now();
    final DateTime thirtyDaysAgo = now.subtract(const Duration(days: 30));

    final List<TrackModel> recentTracks = await _trackRepository.searchTracks(
      SearchTracksPayload(
        query: '',
        genres: genres,
        createdAt: (thirtyDaysAgo, now),
        limit: limit,
        access: <String>['playable'],
      ),
    );

    recentTracks.sort(
      (TrackModel a, TrackModel b) =>
          b.playbackCount.compareTo(a.playbackCount),
    );

    return recentTracks;
  }
}
