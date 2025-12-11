import '../models.dart';
import 'track_model.dart';

class PlaylistModel {
  final String title;
  final String creator;
  final List<TrackModel> songs;

  PlaylistModel({
    required this.title,
    required this.creator,
    required this.songs,
  });
}
