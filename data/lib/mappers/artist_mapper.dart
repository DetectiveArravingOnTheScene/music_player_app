import 'package:domain/models/music_models/artist_model.dart';

import '../entities/abstract/liked_artist_metadata_entity.dart';
import '../entities/isar/local_liked_artist_metadata_entity.dart';
import '../entities/soundcloud/artist_entity.dart';
import '../entities/supabase/cloud_liked_artist_metadata_entity.dart';

class ArtistMapper {
  static ArtistModel toModel({
    required ArtistEntity entity,
    LikedArtistMetadataEntity? likedData,
  }) {
    return ArtistModel(
      urn: entity.urn,
      username: entity.username,
      followers: entity.followers,
      isLiked: likedData != null,
      userListenCount: likedData?.listenCount ?? 0,
      city: entity.city,
      country: entity.country,
      description: entity.description,
      avatarUrl: entity.avatarUrl,
    );
  }

  static CloudLikedArtistMetadataEntity toCloud(
    ArtistModel model,
    String userId,
  ) {
    return CloudLikedArtistMetadataEntity(
      urn: model.urn,
      userId: userId,
      listenCount: model.userListenCount,
      createdAt: DateTime.now(),
    );
  }

  static LocalLikedArtistMetadataEntity toLocal(
    ArtistModel model,
    String userId,
  ) {
    return LocalLikedArtistMetadataEntity(
      urn: model.urn,
      userId: userId,
      listenCount: model.userListenCount,
      createdAt: DateTime.now(),
    );
  }
}
