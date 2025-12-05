import 'package:domain/models/models.dart';

class ArtistModel {
  final String title;
  final List<AlbumModel> albums;

  ArtistModel({required this.title, required this.albums});
}
