import '../../domain.dart';
import '../../models/music_models/access_type.dart';
import '../../models/music_models/collection_model.dart';
import '../../payloads/search_tracks_payload.dart';

class GetTrandingTracksUseCase
    extends FutureUseCaseNoParams<CollectionModel<TrackModel>> {
  final TrackRepository _trackRepository;

  GetTrandingTracksUseCase(TrackRepository trackRepository)
    : _trackRepository = trackRepository;

  @override
  Future<CollectionModel<TrackModel>> execute() async {
    // SoundCloud has no trending endpoint, so i get trending tracks by searching and sorting. I don't know if i should move this into config, since it's a hack
    const List<String> genres = <String>['Pop', 'R&B', 'Hip-hop', 'Electronic'];
    const int limit = 50;
    final DateTime now = DateTime.now();
    final DateTime thirtyDaysAgo = now.subtract(const Duration(days: 30));

    final CollectionModel<TrackModel> recentTracks = await _trackRepository
        .searchTracks(
          SearchTracksPayload(
            query: '',
            genres: genres,
            createdAt: (thirtyDaysAgo, now),
            limit: limit,
            access: <AccessType>[AccessType.playable],
          ),
        );

    recentTracks.items.sort(
      (TrackModel a, TrackModel b) =>
          b.playbackCount.compareTo(a.playbackCount),
    );

    return recentTracks;
  }
}
