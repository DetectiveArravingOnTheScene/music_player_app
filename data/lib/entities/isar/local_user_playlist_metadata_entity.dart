import 'package:isar_plus/isar_plus.dart';

import '../abstract/user_playlist_metadata_entity.dart';

part 'gen/local_user_playlist_metadata_entity.g.dart';

@Collection()
class LocalUserPlaylistMetadataEntity implements UserPlaylistMetadataEntity {
  LocalUserPlaylistMetadataEntity({required this.id});

  @override
  @Index(unique: true)
  final String id;

  @override
  @Index()
  late String userId;

  @override
  late String title;

  @override
  String? description;

  @override
  bool isPublic = false;

  @override
  String? coverUrl;

  @override
  late DateTime createdAt;

  @override
  late DateTime updatedAt;
}
